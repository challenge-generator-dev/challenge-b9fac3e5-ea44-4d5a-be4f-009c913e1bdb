# Configuración del backend remoto de Terraform
# Almacena el estado de Terraform en S3 con bloqueo en DynamoDB

terraform {
  backend "s3" {
    bucket         = "terraform-state-orders-prod"
    key            = "environments/dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}