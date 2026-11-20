# Configuración de instancias EC2 en AWS
# Este módulo define las instancias de computo necesarias para el servicio de órdenes

# Instancia EC2 para el servicio de órdenes
# TODO(reto): implementa este bloque
# resource "aws_instance" "compute" {
# }

# Plantilla user_data para la instancia
resource "local_file" "user_data_script" {
  content = templatefile("${path.module}/user_data.sh.tpl", {
    environment           = var.environment
    application_version   = var.application_version
    database_endpoint     = var.database_endpoint
    database_name         = var.database_name
    database_username     = var.database_username
  })

  filename = "${path.module}/user_data.sh"
}

# Security Group adicional para la instancia (si no se proporcionan)
resource "aws_security_group" "compute" {
  count = length(var.security_group_ids) == 0 ? 1 : 0

  name        = "orders-service-compute-sg"
  description = "Security group para las instancias de computo"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    description = "Salida a internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "orders-service-compute-sg"
    Environment = var.environment
  }
}

# Volumen adicional para datos de la aplicación
resource "aws_ebs_volume" "app_data" {
  availability_zone = var.availability_zone
  size              = var.data_volume_size
  type              = var.data_volume_type
  encrypted         = var.data_encrypted

  tags = {
    Name        = "orders-service-data-volume"
    Environment = var.environment
  }
}

# Attachment del volumen adicional
resource "aws_volume_attachment" "app_data_attachment" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.app_data.id
  instance_id = null # TODO(reto): aws_instance.compute.id
}

# Auto Scaling Group para las instancias
resource "aws_autoscaling_group" "compute" {
  name                = "orders-service-asg"
  vpc_zone_identifier = var.subnet_ids
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  health_check_type   = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.compute.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "orders-service-asg-instance"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Launch Template para el Auto Scaling Group
resource "aws_launch_template" "compute" {
  name_prefix   = "orders-service-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = var.security_group_ids

  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    environment           = var.environment
    application_version   = var.application_version
    database_endpoint     = var.database_endpoint
    database_name         = var.database_name
    database_username     = var.database_username
  }))

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  monitoring {
    enabled = var.enable_monitoring
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "orders-service-lt-instance"
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Variables del módulo de computo
variable "ami_id" {
  description = "ID de la AMI de AWS"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t3.medium"
}

variable "subnet_id" {
  description = "ID de la subnet donde se desplegará la instancia"
  type        = string
}

variable "subnet_ids" {
  description = "IDs de las subnets para el Auto Scaling Group"
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "IDs de los security groups para la instancia"
  type        = list(string)
  default     = []
}

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "Nombre del par de claves SSH"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Entorno de despliegue"
  type        = string
  default     = "production"
}

variable "application_version" {
  description = "Versión de la aplicación a desplegar"
  type        = string
  default     = "latest"
}

variable "database_endpoint" {
  description = "Endpoint de la base de datos"
  type        = string
  default     = ""
}

variable "database_name" {
  description = "Nombre de la base de datos"
  type        = string
  default     = "orders"
}

variable "database_username" {
  description = "Usuario de la base de datos"
  type        = string
  default     = "ordersadmin"
}

variable "root_volume_type" {
  description = "Tipo de volumen raíz"
  type        = string
  default     = "gp3"
}

variable "root_volume_size" {
  description = "Tamaño del volumen raíz en GB"
  type        = number
  default     = 30
}

variable "root_encrypted" {
  description = "Indica si el volumen raíz debe estar encriptado"
  type        = bool
  default     = true
}

variable "data_volume_size" {
  description = "Tamaño del volumen de datos en GB"
  type        = number
  default     = 50
}

variable "data_volume_type" {
  description = "Tipo de volumen de datos"
  type        = string
  default     = "gp3"
}

variable "data_encrypted" {
  description = "Indica si el volumen de datos debe estar encriptado"
  type        = bool
  default     = true
}

variable "availability_zone" {
  description = "Zona de disponibilidad"
  type        = string
  default     = "us-east-1a"
}

variable "enable_monitoring" {
  description = "Habilitar monitoreo detallado"
  type        = bool
  default     = true
}

variable "min_size" {
  description = "Tamaño mínimo del Auto Scaling Group"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Tamaño máximo del Auto Scaling Group"
  type        = number
  default     = 4
}

variable "desired_capacity" {
  description = "Capacidad deseada del Auto Scaling Group"
  type        = number
  default     = 2
}

# Outputs del módulo de computo
output "instance_id" {
  description = "ID de la instancia EC2"
  value = null # TODO(reto): aws_instance.compute.id
}

output "instance_private_ip" {
  description = "IP privada de la instancia"
  value = null # TODO(reto): aws_instance.compute.private_ip
}

output "instance_public_ip" {
  description = "IP pública de la instancia"
  value = null # TODO(reto): aws_instance.compute.public_ip
}

output "autoscaling_group_name" {
  description = "Nombre del Auto Scaling Group"
  value       = aws_autoscaling_group.compute.name
}

output "autoscaling_group_arn" {
  description = "ARN del Auto Scaling Group"
  value       = aws_autoscaling_group.compute.arn
}

output "launch_template_id" {
  description = "ID del Launch Template"
  value       = aws_launch_template.compute.id
}