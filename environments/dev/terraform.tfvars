# Variables de entorno para el entorno de desarrollo
# Estas variables se cargan automáticamente cuando Terraform se ejecuta en este directorio

# Configuración de red
environment             = "dev"
region                  = "us-east-1"
vpc_cidr                = "10.0.0.0/16"
public_subnet_cidr_1    = "10.0.1.0/24"
public_subnet_cidr_2    = "10.0.2.0/24"
private_subnet_cidr_1   = "10.0.10.0/24"
private_subnet_cidr_2   = "10.0.11.0/24"

# Configuración de base de datos
db_instance_class       = "db.t3.micro"
allocated_storage       = 20
storage_type            = "gp3"
db_name                 = "orders_dev"
db_username             = "ordersadmin"
db_password             = "dev_password_change_me"
backup_retention_period = 1
skip_final_snapshot     = true
multi_az                = false

# Configuración de compute
ami_id                  = "ami-0c55b159cbfafe1f0"
instance_type           = "t3.micro"
key_name                = "dev-key-pair"
root_volume_size        = 20
root_volume_type        = "gp3"
data_volume_size        = 30
data_volume_type        = "gp3"
min_size                = 1
max_size                = 2
desired_capacity        = 1
enable_monitoring       = false

# Configuración de aplicación
application_version     = "dev-latest"
database_endpoint       = ""
database_name           = "orders_dev"
database_username       = "ordersadmin"