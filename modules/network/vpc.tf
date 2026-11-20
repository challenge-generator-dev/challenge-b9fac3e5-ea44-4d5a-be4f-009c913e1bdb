# Configuración de red en AWS - VPC, subnets y security groups
# Este módulo define la infraestructura de red necesaria para el servicio de órdenes

# VPC principal para el servicio de órdenes
# TODO(reto): implementa este bloque
# resource "aws_vpc" "network" {
# }

# Subnet pública para el balanceador de carga
resource "aws_subnet" "public_subnet_1" {
  vpc_id = null # TODO(reto): aws_vpc.network.id
  cidr_block              = var.public_subnet_cidr_1 != "" ? var.public_subnet_cidr_1 : "10.0.1.0/24"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "orders-service-public-subnet-1"
    Environment = var.environment
    Type        = "public"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id = null # TODO(reto): aws_vpc.network.id
  cidr_block              = var.public_subnet_cidr_2 != "" ? var.public_subnet_cidr_2 : "10.0.2.0/24"
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true

  tags = {
    Name        = "orders-service-public-subnet-2"
    Environment = var.environment
    Type        = "public"
  }
}

# Subnets privadas para las instancias de aplicación
resource "aws_subnet" "private_subnet_1" {
  vpc_id = null # TODO(reto): aws_vpc.network.id
  cidr_block        = var.private_subnet_cidr_1 != "" ? var.private_subnet_cidr_1 : "10.0.10.0/24"
  availability_zone = "${var.region}a"

  tags = {
    Name        = "orders-service-private-subnet-1"
    Environment = var.environment
    Type        = "private"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id = null # TODO(reto): aws_vpc.network.id
  cidr_block        = var.private_subnet_cidr_2 != "" ? var.private_subnet_cidr_2 : "10.0.20.0/24"
  availability_zone = "${var.region}b"

  tags = {
    Name        = "orders-service-private-subnet-2"
    Environment = var.environment
    Type        = "private"
  }
}

# Internet Gateway para la VPC
resource "aws_internet_gateway" "main" {
  vpc_id = null # TODO(reto): aws_vpc.network.id

  tags = {
    Name        = "orders-service-igw"
    Environment = var.environment
  }
}

# Tabla de rutas pública
resource "aws_route_table" "public" {
  vpc_id = null # TODO(reto): aws_vpc.network.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "orders-service-public-rt"
    Environment = var.environment
  }
}

# Asociación de subnets públicas con la tabla de rutas
resource "aws_route_table_association" "public_subnet_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_subnet_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public.id
}

# Security Group para las instancias de aplicación
resource "aws_security_group" "app" {
  name        = "orders-service-app-sg"
  description = "Security group para las instancias de aplicación del servicio de órdenes"
  vpc_id = null # TODO(reto): aws_vpc.network.id

  ingress {
    description = "HTTP desde ALB"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description = "HTTPS desde ALB"
    from_port   = 8443
    to_port     = 8443
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
    Name        = "orders-service-app-sg"
    Environment = var.environment
  }
}

# Security Group para el balanceador de carga
resource "aws_security_group" "alb" {
  name        = "orders-service-alb-sg"
  description = "Security group para el Application Load Balancer"
  vpc_id = null # TODO(reto): aws_vpc.network.id

  ingress {
    description = "HTTP desde internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS desde internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Salida a las instancias"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]
  }

  tags = {
    Name        = "orders-service-alb-sg"
    Environment = var.environment
  }
}

# Security Group para la base de datos RDS
resource "aws_security_group" "rds" {
  name        = "orders-service-rds-sg"
  description = "Security group para la base de datos RDS"
  vpc_id = null # TODO(reto): aws_vpc.network.id

  ingress {
    description = "PostgreSQL desde instancias de aplicación"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.10.0/24", "10.0.20.0/24"]
  }

  egress {
    description = "Salida a internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "orders-service-rds-sg"
    Environment = var.environment
  }
}

# Variables del módulo de red
variable "environment" {
  description = "Entorno de despliegue"
  type        = string
  default     = "production"
}

variable "region" {
  description = "Región de AWS"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block para la VPC"
  type        = string
  default     = ""
}

variable "public_subnet_cidr_1" {
  description = "CIDR block para la subnet pública 1"
  type        = string
  default     = ""
}

variable "public_subnet_cidr_2" {
  description = "CIDR block para la subnet pública 2"
  type        = string
  default     = ""
}

variable "private_subnet_cidr_1" {
  description = "CIDR block para la subnet privada 1"
  type        = string
  default     = ""
}

variable "private_subnet_cidr_2" {
  description = "CIDR block para la subnet privada 2"
  type        = string
  default     = ""
}

# Outputs del módulo de red
output "vpc_id" {
  description = "ID de la VPC creada"
  value = null # TODO(reto): aws_vpc.network.id
}

output "vpc_cidr" {
  description = "CIDR block de la VPC"
  value = null # TODO(reto): aws_vpc.network.cidr_block
}

output "public_subnet_ids" {
  description = "IDs de las subnets públicas"
  value       = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
}

output "private_subnet_ids" {
  description = "IDs de las subnets privadas"
  value       = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}

output "security_group_app_id" {
  description = "ID del security group de aplicación"
  value       = aws_security_group.app.id
}

output "security_group_alb_id" {
  description = "ID del security group del ALB"
  value       = aws_security_group.alb.id
}

output "security_group_rds_id" {
  description = "ID del security group de RDS"
  value       = aws_security_group.rds.id
}