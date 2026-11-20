# Salidas de la raiz del proyecto.
# Terraform solo permite referenciar modulos declarados en el mismo directorio,
# por eso el entorno orquestado en environments/ se invoca aqui y las salidas
# se reexponen desde el modulo "orders_environment".

module "orders_environment" {
  source = "./environments"
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.orders_environment.vpc_id
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.orders_environment.public_subnet_ids
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.orders_environment.private_subnet_ids
}

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = module.orders_environment.instance_id
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = module.orders_environment.instance_public_ip
}

output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = module.orders_environment.database_endpoint
  sensitive   = true
}

output "rds_port" {
  description = "The port of the RDS instance"
  value       = module.orders_environment.database_port
}