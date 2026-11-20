variable "environment" {
  type        = string
  default     = "production"
}

variable "region" {
  type        = string
  default     = "us-east-1"
}

variable "db_instance_class" {
  type        = string
  default     = "db.t3.medium"
}

variable "allocated_storage" {
  type        = number
  default     = 20
}

variable "storage_type" {
  type        = string
  default     = "gp3"
}

variable "db_name" {
  type        = string
  default     = "orders"
}

variable "db_username" {
  type        = string
  default     = "ordersadmin"
}

variable "db_password" {
  type        = string
  default     = ""
  sensitive   = true
}

variable "vpc_security_group_ids" {
  type        = list(string)
  default     = []
}

variable "db_subnet_group_name" {
  type        = string
  default     = ""
}

variable "backup_retention_period" {
  type        = number
  default     = 7
}

variable "skip_final_snapshot" {
  type        = bool
  default     = true
}

variable "final_snapshot_identifier" {
  type        = string
  default     = ""
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  default     = ["error", "general", "slowquery"]
}

variable "monitoring_interval" {
  type        = number
  default     = 60
}

variable "monitoring_role_arn" {
  type        = string
  default     = ""
}

variable "multi_az" {
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  type        = bool
  default     = false
}

variable "engine_version" {
  type        = string
  default     = "15.7"
}

variable "master_password" {
  type        = string
  default     = ""
  sensitive   = true
}

# TODO(reto): implementa este bloque
# resource "aws_rds_instance" "database" {
# }

resource "aws_db_instance_automated_backups_replication" "database" {
  count = var.backup_retention_period > 0 ? 1 : 0
  source_db_instance_arn = null # TODO(reto): aws_rds_instance.database.arn
  retention_period       = var.backup_retention_period
}

resource "aws_db_option_group" "database" {
  name                     = "${var.db_name}-options"
  engine_name              = "postgres"
  major_engine_version     = var.engine_version
  option_group_description = "Option group for ${var.db_name}"

  option {
    option_name = "NULL"
  }
}

resource "aws_db_parameter_group" "database" {
  name   = "${var.db_name}-params"
  family = "postgres${split(".", var.engine_version)[0]}"

  parameter {
    name  = "max_connections"
    value = "100"
  }

  parameter {
    name  = "shared_buffers"
    value = "${var.db_instance_class == "db.t3.micro" ? "32768" : var.db_instance_class == "db.t3.small" ? "65536" : "131072"}"
  }

  parameter {
    name  = "work_mem"
    value = "4096"
  }

  parameter {
    name  = "maintenance_work_mem"
    value = "65536"
  }

  parameter {
    name  = "effective_cache_size"
    value = "${var.db_instance_class == "db.t3.micro" ? "98304" : var.db_instance_class == "db.t3.small" ? "196608" : "393216"}"
  }
}

output "database_address" {
  description = "The address of the RDS instance"
  value = null # TODO(reto): aws_rds_instance.database.address
}

output "database_arn" {
  description = "The ARN of the RDS instance"
  value = null # TODO(reto): aws_rds_instance.database.arn
}

output "database_endpoint" {
  description = "The connection endpoint"
  value = null # TODO(reto): aws_rds_instance.database.endpoint
}

output "database_id" {
  description = "The RDS instance ID"
  value = null # TODO(reto): aws_rds_instance.database.id
}

output "database_name" {
  description = "The database name"
  value = null # TODO(reto): aws_rds_instance.database.db_name
}

output "database_port" {
  description = "The database port"
  value = null # TODO(reto): aws_rds_instance.database.port
}

output "database_resource_id" {
  description = "The RDS instance resource ID"
  value = null # TODO(reto): aws_rds_instance.database.resource_id
}

output "database_status" {
  description = "The RDS instance status"
  value = null # TODO(reto): aws_rds_instance.database.status
}