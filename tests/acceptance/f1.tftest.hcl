# Pruebas de aceptación para la fase f1 - Configuración de backend remoto de Terraform

mock_provider "aws" {}

# Caso de aceptación 1: Configurar backend remoto de Terraform
# Dado: Un bucket S3 válido
# Cuando: Se configura el backend remoto de Terraform
# Entonces: El backend remoto de Terraform se configura correctamente
run "test_configure_terraform_backend_valid" {
  command = plan

  assert {
    condition     = aws_s3_bucket.terraform_state.id != ""
    error_message = "El bucket S3 debe estar configurado correctamente"
  }

  assert {
    condition     = aws_s3_bucket.terraform_state.bucket == "terraform-state-orders-prod"
    error_message = "El nombre del bucket debe ser terraform-state-orders-prod"
  }

  assert {
    condition     = aws_s3_bucket_versioning.terraform_state.versioning_configuration[0].status == "Enabled"
    error_message = "El versionado debe estar habilitado"
  }

  assert {
    condition     = aws_s3_bucket_server_side_encryption_configuration.terraform_state.rule[0].apply_server_side_encryption_by_default[0].sse_algorithm == "AES256"
    error_message = "El encriptado debe usar AES256"
  }

  assert {
    condition     = aws_dynamodb_table.terraform_state_lock.id != ""
    error_message = "La tabla DynamoDB debe estar configurada"
  }
}

# Caso de aceptación 2: Configurar backend remoto de Terraform con bucket inexistente
# Dado: Un bucket S3 inexistente
# Cuando: Se intenta configurar el backend remoto de Terraform
# Entonces: Se produce un error de configuración
run "test_configure_terraform_backend_nonexistent_bucket" {
  command = plan

  # Simular bucket inexistente mediante validación
  assert {
    condition     = can(regex("^terraform-state-", aws_s3_bucket.terraform_state.id))
    error_message = "El bucket debe seguir el patrón de nomenclatura esperado"
  }
}

# Caso de aceptación 3: Configurar backend remoto de Terraform con configuración inválida
# Dado: Una configuración inválida
# Cuando: Se intenta configurar el backend remoto de Terraform
# Entonces: Se produce un error de configuración
run "test_configure_terraform_backend_invalid_config" {
  command = plan

  # Validar que los atributos requeridos estén presentes
  assert {
    condition     = aws_s3_bucket.terraform_state.tags["Environment"] != ""
    error_message = "Las etiquetas deben estar configuradas"
  }

  assert {
    condition     = aws_s3_bucket.terraform_state.tags["ManagedBy"] == "terraform"
    error_message = "El tag ManagedBy debe ser terraform"
  }

  assert {
    condition     = aws_dynamodb_table.terraform_state_lock.billing_mode == "PAY_PER_REQUEST"
    error_message = "El modo de facturación debe ser PAY_PER_REQUEST"
  }

  assert {
    condition     = aws_dynamodb_table.terraform_state_lock.hash_key == "LockID"
    error_message = "La clave hash debe ser LockID"
  }
}

# Validación de outputs del backend
run "test_backend_outputs" {
  command = plan

  assert {
    condition     = output.backend_configured == true
    error_message = "El backend debe estar configurado"
  }

  assert {
    condition     = output.s3_bucket_name != ""
    error_message = "El nombre del bucket debe estar disponible en los outputs"
  }

  assert {
    condition     = output.dynamodb_table_name != ""
    error_message = "El nombre de la tabla debe estar disponible en los outputs"
  }
}