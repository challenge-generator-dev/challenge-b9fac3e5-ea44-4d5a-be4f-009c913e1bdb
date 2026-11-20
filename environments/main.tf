# Integración de módulos de infraestructura para el servicio de órdenes
# Este archivo orquesta la creación de red, compute y base de datos

# ============================================
# MÓDULO DE RED
# ============================================

module "network" {
  source = "../modules/network"

  environment           = var.environment
  region                = var.region
  vpc_cidr              = var.vpc_cidr
  public_subnet_cidr_1  = var.public_subnet_cidr_1
  public_subnet_cidr_2  = var.public_subnet_cidr_2
  private_subnet_cidr_1 = var.private_subnet_cidr_1
  private_subnet_cidr_2 = var.private_subnet_cidr_2
}

# ============================================
# MÓDULO DE BASE DE DATOS
# ============================================

module "database" {
  source = "../modules/database"

  environment                      = var.environment
  region                           = var.region
  db_instance_class                = var.db_instance_class
  allocated_storage                = var.allocated_storage
  storage_type                     = var.storage_type
  db_name                          = var.db_name
  db_username                      = var.db_username
  db_password                      = var.db_password
  vpc_security_group_ids           = [module.network.security_group_rds_id]
  db_subnet_group_name             = "orders-subnet-group"
  backup_retention_period          = var.backup_retention_period
  skip_final_snapshot              = var.skip_final_snapshot
  enabled_cloudwatch_logs_exports  = ["error", "general", "slowquery"]
  multi_az                         = var.multi_az
  publicly_accessible              = var.publicly_accessible
  engine_version                   = var.engine_version
}

# ============================================
# MÓDULO DE COMPUTE
# ============================================

module "compute" {
  source = "../modules/compute"

  ami_id                = var.ami_id
  instance_type         = var.instance_type
  subnet_id             = module.network.private_subnet_ids[0]
  subnet_ids            = module.network.private_subnet_ids
  security_group_ids    = [module.network.security_group_app_id]
  vpc_id                = module.network.vpc_id
  key_name              = var.key_name
  environment           = var.environment
  application_version   = var.application_version
  database_endpoint     = module.database.database_endpoint
  database_name         = var.database_name
  database_username     = var.database_username
  root_volume_type      = var.root_volume_type
  root_volume_size      = var.root_volume_size
  root_encrypted        = var.root_encrypted
  data_volume_size      = var.data_volume_size
  data_volume_type      = var.data_volume_type
  data_encrypted        = var.data_encrypted
  availability_zone     = "${var.region}a"
  enable_monitoring     = var.enable_monitoring
  min_size              = var.min_size
  max_size              = var.max_size
  desired_capacity      = var.desired_capacity
}

# ============================================
# VARIABLES
# ============================================

variable "environment" {
  description = "Entorno de despliegue (dev, staging, production)"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "Región de AWS"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block para la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_1" {
  description = "CIDR para la primera subnet pública"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_cidr_2" {
  description = "CIDR para la segunda subnet pública"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_cidr_1" {
  description = "CIDR para la primera subnet privada"
  type        = string
  default     = "10.0.10.0/24"
}

variable "private_subnet_cidr_2" {
  description = "CIDR para la segunda subnet privada"
  type        = string
  default     = "10.0.11.0/24"
}

variable "db_instance_class" {
  description = "Clase de instancia de base de datos"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Almacenamiento asignado para RDS en GB"
  type        = number
  default     = 20
}

variable "storage_type" {
  description = "Tipo de almacenamiento de RDS"
  type        = string
  default     = "gp3"
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
  default     = "orders"
}

variable "db_username" {
  description = "Usuario maestro de la base de datos"
  type        = string
  default     = "ordersadmin"
}

variable "db_password" {
  description = "Contraseña del usuario maestro"
  type        = string
  default     = ""
  sensitive   = true
}

variable "backup_retention_period" {
  description = "Días de retención de backups"
  type        = number
  default     = 7
}

variable "skip_final_snapshot" {
  description = "Omite la snapshot final al destruir"
  type        = bool
  default     = true
}

variable "multi_az" {
  description = "Habilita Multi-AZ para RDS"
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  description = "Hace la base de datos públicamente accesible"
  type        = bool
  default     = false
}

variable "engine_version" {
  description = "Versión del motor de PostgreSQL"
  type        = string
  default     = "15.7"
}

variable "ami_id" {
  description = "ID de la AMI para las instancias"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Nombre del par de claves SSH"
  type        = string
  default     = ""
}

variable "root_volume_size" {
  description = "Tamaño del volumen raíz en GB"
  type        = number
  default     = 20
}

variable "root_volume_type" {
  description = "Tipo del volumen raíz"
  type        = string
  default     = "gp3"
}

variable "root_encrypted" {
  description = "Cifra el volumen raíz"
  type        = bool
  default     = true
}

variable "data_volume_size" {
  description = "Tamaño del volumen de datos en GB"
  type        = number
  default     = 30
}

variable "data_volume_type" {
  description = "Tipo del volumen de datos"
  type        = string
  default     = "gp3"
}

variable "data_encrypted" {
  description = "Cifra el volumen de datos"
  type        = bool
  default     = true
}

variable "min_size" {
  description = "Tamaño mínimo del Auto Scaling Group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Tamaño máximo del Auto Scaling Group"
  type        = number
  default     = 4
}

variable "desired_capacity" {
  description = "Capacidad deseada del Auto Scaling Group"
  type        = number
  default     = 1
}

variable "enable_monitoring" {
  description = "Habilita CloudWatch Monitoring"
  type        = bool
  default     = true
}

variable "application_version" {
  description = "Versión de la aplicación a desplegar"
  type        = string
  default     = "latest"
}

variable "database_endpoint" {
  description = "Endpoint de la base de datos (para referencia)"
  type        = string
  default     = ""
}

variable "database_name" {
  description = "Nombre de la base de datos de la aplicación"
  type        = string
  default     = "orders"
}

variable "database_username" {
  description = "Usuario de la base de datos de la aplicación"
  type        = string
  default     = "ordersadmin"
}

# ============================================
# OUTPUTS
# ============================================

output "vpc_id" {
  description = "ID de la VPC creada"
  value       = module.network.vpc_id
}

output "vpc_cidr" {
  description = "CIDR de la VPC"
  value       = module.network.vpc_cidr
}

output "public_subnet_ids" {
  description = "IDs de las subnets públicas"
  value       = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs de las subnets privadas"
  value       = module.network.private_subnet_ids
}

output "database_endpoint" {
  description = "Endpoint de la base de datos RDS"
  value       = module.database.database_endpoint
  sensitive   = true
}

output "database_name" {
  description = "Nombre de la base de datos"
  value       = module.database.database_name
}

output "database_port" {
  description = "Puerto de la base de datos"
  value       = module.database.database_port
}

output "autoscaling_group_name" {
  description = "Nombre del Auto Scaling Group"
  value       = module.compute.autoscaling_group_name
}

output "autoscaling_group_arn" {
  description = "ARN del Auto Scaling Group"
  value       = module.compute.autoscaling_group_arn
}

output "launch_template_id" {
  description = "ID del Launch Template"
  value       = module.compute.launch_template_id
}

output "instance_id" {
  description = "ID de la instancia EC2 de la aplicación"
  value       = module.compute.instance_id
}

output "instance_public_ip" {
  description = "IP pública de la instancia EC2 de la aplicación"
  value       = module.compute.instance_public_ip
}

output "security_group_app_id" {
  description = "ID del security group de la aplicación"
  value       = module.network.security_group_app_id
}

output "security_group_alb_id" {
  description = "ID del security group del ALB"
  value       = module.network.security_group_alb_id
}

output "security_group_rds_id" {
  description = "ID del security group de RDS"
  value       = module.network.security_group_rds_id
}