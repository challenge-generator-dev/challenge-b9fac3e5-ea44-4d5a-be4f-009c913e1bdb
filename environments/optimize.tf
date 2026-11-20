# Configuración del backend remoto de Terraform con S3
# Este archivo contiene la configuración del bucket S3 para almacenar el estado de Terraform

terraform {
  backend "s3" {
    bucket         = "terraform-state-orders-prod"
    key            = "orders-service/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}

# Recurso S3 para el backend remoto de Terraform
# TODO(reto): implementa este bloque
# resource "aws_s3_bucket" "terraform_state" {
# }

# Configuración de versionado del bucket S3
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = null # TODO(reto): aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Configuración de encriptado del bucket S3
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = null # TODO(reto): aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Tabla DynamoDB para el lock del estado de Terraform
resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform State Lock Table"
    Environment = "production"
    ManagedBy   = "terraform"
  }
}

# Función para validar la configuración del backend remoto
function "validate_backend_config" "backend_validation" {
  params = [
    bucket_name,
    region,
    enable_versioning,
    enable_encryption
  ]

  result = {
    is_valid = bucket_name != "" && region != "" && enable_versioning == true && enable_encryption == true
    errors   = []
  }

  if bucket_name == "" {
    result.errors = concat(result.errors, ["El nombre del bucket no puede estar vacío"])
  }

  if region == "" {
    result.errors = concat(result.errors, ["La región no puede estar vacía"])
  }

  if enable_versioning != true {
    result.errors = concat(result.errors, ["El versionado debe estar habilitado"])
  }

  if enable_encryption != true {
    result.errors = concat(result.errors, ["El encriptado debe estar habilitado"])
  }

  return result
}

# Validación del bucket S3 para el backend remoto
resource "null_resource" "validate_terraform_backend" {
  triggers = {
    bucket_name = null # TODO(reto): aws_s3_bucket.terraform_state.id
    table_name  = aws_dynamodb_table.terraform_state_lock.id
  }

  provisioner "local-exec" {
    command = "echo 'Validando configuración del backend remoto de Terraform'"
  }
}

# Output para exponer la información del backend configurado
output "backend_configured" {
  description = "Indica si el backend remoto está configurado correctamente"
  value = null # TODO(reto): aws_s3_bucket.terraform_state.id != "" && aws_dynamodb_table.terraform_state_lock.id != ""
}

output "s3_bucket_name" {
  description = "Nombre del bucket S3 para el estado de Terraform"
  value = null # TODO(reto): aws_s3_bucket.terraform_state.id
}

output "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB para el lock del estado"
  value       = aws_dynamodb_table.terraform_state_lock.id
}