# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener el proyecto completo y arrancable. Guarda los archivos que te devuelva en la
carpeta del repo, respetando exactamente las rutas.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Superficie de practica — NO resuelvas

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs.

- `environments/optimize.tf` — La pieza p1 (configuración de backend remoto de Terraform, fase f1) vive aqui: este archivo es su unico dueno (blueprint v2).
- `modules/network/vpc.tf` — La pieza p2 (configuración de red en AWS, fase f2) vive aqui: este archivo es su unico dueno (blueprint v2).
- `modules/compute/instance.tf` — La pieza p3 (configuración de instancias en AWS, fase f2) vive aqui: este archivo es su unico dueno (blueprint v2).
- `modules/database/rds.tf` — La pieza p4 (configuración de base de datos en AWS, fase f2) vive aqui: este archivo es su unico dueno (blueprint v2).

## Herramientas

- **Java**: Tecnologia pedida para este reto: forma parte del stack con el que se resuelve el ejercicio.

## Referencias no verificadas

Referencias no verificadas para: .hcl. El analisis estatico no cubre esos lenguajes: que no se haya listado nada NO garantiza que no haya referencias colgando.

## Como saber que terminaste

```bash
terraform init -backend=false && terraform -chdir=environments init -backend=false && terraform -chdir=modules/compute init -backend=false && terraform -chdir=modules/database init -backend=false && terraform -chdir=modules/network init -backend=false && terraform validate && terraform -chdir=environments validate && terraform -chdir=modules/compute validate && terraform -chdir=modules/database validate && terraform -chdir=modules/network validate
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Backend, Especialidad Desarrollador, Tecnología Java, Senior L2

### Brecha de conocimiento
Aprovisionar infraestructura con Terraform

### Misión / candidato
Versionar la infraestructura del servicio

### Reto
- Tema: Infraestructura como codigo para el servicio de ordenes
- Seniority: senior-l2
- Tipo: practical
- Título: Aprovisionamiento de Infraestructura con Terraform para el Servicio de Ordenes
- Tiempo estimado: 8 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Configuración Inicial de Terraform — objetivo: Configurar el entorno de Terraform y separar los módulos por red, computo y base de datos. — entregable (NO resolver): Estructura de directorios de Terraform con módulos separados y backend remoto configurado.
- Fase 2: Desarrollo de Módulos de Terraform — objetivo: Desarrollar los módulos de Terraform para red, computo y base de datos. — entregable (NO resolver): Módulos de Terraform desarrollados para red, computo y base de datos.
- Fase 3: Aprovisionamiento de Infraestructura — objetivo: Aprovisionar la infraestructura AWS utilizando los módulos de Terraform desarrollados. — entregable (NO resolver): Infraestructura AWS aprovisionada y documentada.
- Fase 4: Validación y Optimización — objetivo: Validar el funcionamiento de la infraestructura y optimizar los módulos de Terraform. — entregable (NO resolver): Infraestructura validada y módulos de Terraform optimizados.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (entrega de archivos).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Entrega de archivos
Entregá cada archivo con su ruta completa, respetando exactamente la estructura de rutas
indicada por los marcadores: un bloque por archivo, precedido por su ruta. No generes ZIPs
ni archivos adjuntos.
La entrega debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: Entregá los archivos completos al finalizar. No preguntes si el usuario
quiere recibirlos. Simplemente entregalos; No debes desplegar en el chat el resumen de lo que arreglaste, solo entregá los archivos.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del último archivo entregado
No preguntes si el usuario quiere los archivos: simplemente entregalos siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: outputs.tf ===
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

// === ARCHIVO: variables.tf ===
variable "region" {
  description = "AWS region where resources will be deployed"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "db_name" {
  description = "Name of the database"
  type        = string
}

variable "db_username" {
  description = "Database administrator username"
  type        = string
}

variable "db_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
}

// === ARCHIVO: versions.tf ===
terraform {
  required_version = ">= 1.9.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.100.0"
    }
  }
}

// === ARCHIVO: providers.tf ===
provider "aws" {
  region = "us-east-1"
}

// === ARCHIVO: environments/optimize.tf ===
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

// === ARCHIVO: modules/network/vpc.tf ===
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

// === ARCHIVO: modules/compute/instance.tf ===
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

// === ARCHIVO: modules/database/rds.tf ===
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

// === ARCHIVO: tests/acceptance/f1.tftest.hcl ===
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

// === ARCHIVO: tests/acceptance/f2.tftest.hcl ===
mock_provider "aws" {}

mock_data "aws_vpc" {
  defaults {
    id = "vpc-12345678"
    cidr_block = "10.0.0.0/16"
  }
}

mock_data "aws_subnet" {
  defaults {
    id = "subnet-12345678"
    vpc_id = "vpc-12345678"
  }
}

mock_data "aws_security_group" {
  defaults {
    id = "sg-12345678"
    vpc_id = "vpc-12345678"
  }
}

run "test_configure_vpc_valid_config" {
  command = plan

  assert {
    condition     = aws_vpc.network.id != ""
    error_message = "VPC should be configured with valid ID"
  }
}

run "test_configure_vpc_invalid_config" {
  command = plan

  variables {
    vpc_cidr = "invalid-cidr"
  }

  expect_failures = [
    variable.vpc_cidr,
  ]
}

run "test_configure_instance_valid_config" {
  command = plan

  variables {
    ami_id     = "ami-12345678"
    subnet_id  = "subnet-12345678"
  }

  assert {
    condition     = aws_instance.compute.id != ""
    error_message = "Instance should be configured with valid ID"
  }
}

run "test_configure_instance_invalid_config" {
  command = plan

  variables {
    ami_id    = ""
    subnet_id = "subnet-12345678"
  }

  expect_failures = [
    variable.ami_id,
  ]
}

run "test_configure_rds_valid_config" {
  command = plan

  variables {
    db_name     = "orders"
    db_username = "ordersadmin"
    master_password = "SecurePassword123!"
    vpc_security_group_ids = ["sg-12345678"]
    db_subnet_group_name = "main"
  }

  assert {
    condition     = aws_rds_instance.database.id != ""
    error_message = "RDS instance should be configured with valid ID"
  }

  assert {
    condition     = aws_rds_instance.database.engine == "postgres"
    error_message = "RDS instance should use postgres engine"
  }

  assert {
    condition     = aws_rds_instance.database.storage_encrypted == true
    error_message = "RDS instance should have encryption enabled"
  }
}

run "test_configure_rds_invalid_config" {
  command = plan

  variables {
    db_name     = ""
    db_username = "ordersadmin"
    master_password = "SecurePassword123!"
    vpc_security_group_ids = ["sg-12345678"]
    db_subnet_group_name = "main"
  }

  expect_failures = [
    variable.db_name,
  ]
}

// === ARCHIVO: tests/acceptance/f3.tftest.hcl ===
mock_provider "aws" {}

run "test_provision_infrastructure_valid_config" {
  command = plan

  assert {
    condition     = aws_s3_bucket.terraform_state.id != ""
    error_message = "S3 bucket should be created for terraform state"
  }

  assert {
    condition     = aws_s3_bucket_versioning.terraform_state[0].versioning_configuration[0].status == "Enabled"
    error_message = "S3 bucket versioning should be enabled"
  }

  assert {
    condition     = aws_s3_bucket_server_side_encryption_configuration.terraform_state[0].rule[0].apply_server_side_encryption_by_default[0].sse_algorithm == "AES256"
    error_message = "S3 bucket should use AES256 encryption"
  }

  assert {
    condition     = aws_dynamodb_table.terraform_state_lock[0].hash_key == "LockID"
    error_message = "DynamoDB table should have LockID as hash key"
  }
}

run "test_provision_infrastructure_invalid_config" {
  command = plan

  variables {
    bucket_name = ""
  }

  expect_failures = [
    resource.aws_s3_bucket.terraform_state,
  ]
}

run "test_provision_infrastructure_nonexistent_module" {
  command = plan

  variables {
    use_nonexistent_module = true
  }

  expect_failures = [
    module.nonexistent_module,
  ]
}

run "test_provision_infrastructure_terraform_error" {
  command = plan

  variables {
    invalid_backend_config = true
  }

  expect_failures = [
    resource.aws_s3_bucket.terraform_state,
  ]
}

// === ARCHIVO: tests/acceptance/f4.tftest.hcl ===
mock_provider "aws" {}

run "test_validate_infrastructure_functioning" {
  command = plan

  assert {
    condition     = output.backend_configured == true
    error_message = "Backend should be configured"
  }

  assert {
    condition     = output.s3_bucket_name != ""
    error_message = "S3 bucket name should be exposed"
  }

  assert {
    condition     = output.dynamodb_table_name != ""
    error_message = "DynamoDB table name should be exposed"
  }
}

run "test_optimize_terraform_modules" {
  command = plan

  assert {
    condition     = aws_s3_bucket.terraform_state.bucket != ""
    error_message = "S3 bucket should have valid name"
  }

  assert {
    condition     = aws_s3_bucket_server_side_encryption_configuration.terraform_state[0].rule[0].apply_server_side_encryption_by_default[0].sse_algorithm == "AES256"
    error_message = "Encryption should be optimized to AES256"
  }

  assert {
    condition     = aws_s3_bucket_versioning.terraform_state[0].versioning_configuration[0].status == "Enabled"
    error_message = "Versioning should be enabled for state management"
  }
}

run "test_validate_terraform_modules_invalid_config" {
  command = plan

  variables {
    bucket_name = "invalid-name-with-underscores"
  }

  expect_failures = [
    resource.aws_s3_bucket.terraform_state,
  ]
}

run "test_validate_terraform_modules_syntax_errors" {
  command = plan

  variables {
    enable_syntax_errors = true
  }

  expect_failures = [
    resource.aws_s3_bucket.terraform_state,
  ]
}

// === ARCHIVO: environments/dev/terraform.tfvars ===
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

// === ARCHIVO: environments/backend.tf ===
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

// === ARCHIVO: environments/main.tf ===
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

// === ARCHIVO: README.md ===
# Infraestructura como Código - Servicio de Órdenes

## Descripción del Proyecto

Este proyecto contiene la definición de infraestructura AWS para el servicio de órdenes, implementado con Terraform en una arquitectura modular.

## Estructura de Directorios

```
.
├── environments/          # Configuraciones por entorno
│   ├── dev/              # Variables para entorno de desarrollo
│   ├── optimize.tf       # Backend remoto y outputs
│   ├── main.tf           # Composición de módulos
│   └── backend.tf        # Configuración de estado remoto
├── modules/              # Módulos reutilizables
│   ├── network/          # VPC, subnets, security groups
│   ├── compute/          # EC2, ASG, EBS
│   └── database/         # RDS PostgreSQL
├── tests/                # Pruebas de aceptación
│   └── acceptance/       # Tests de validación
├── versions.tf           # Versiones de Terraform y providers
└── providers.tf          # Configuración de providers
```

## Requisitos Previos

- Terraform >= 1.9.0
- AWS CLI configurado con credenciales
- Acceso a la cuenta de AWS

## Comandos de Validación Local

### Inicializar Terraform
```bash
terraform init
```

### Validar sintaxis
```bash
terraform validate
```

### Planificar cambios
```bash
terraform plan -var-file=environments/dev/terraform.tfvars
```

### Aplicar infraestructura
```bash
terraform apply -var-file=environments/dev/terraform.tfvars
```

### Destruir infraestructura
```bash
terraform destroy -var-file=environments/dev/terraform.tfvars
```

## Módulos Disponibles

### Network (modules/network/)
- VPC con CIDR configurable
- Subnets públicas y privadas
- Internet Gateway
- Route Tables
- Security Groups para ALB, App y RDS

### Compute (modules/compute/)
- Auto Scaling Group
- Launch Template
- Instancias EC2
- Volúmenes EBS
- User Data script

### Database (modules/database/)
- RDS PostgreSQL
- Parameter Groups
- Option Groups
- Replicación de backups

## Configuración de Backend Remoto

El estado de Terraform se almacena en S3 con bloqueo en DynamoDB. La configuración se encuentra en `environments/optimize.tf`.

## Variables de Entorno

Las credenciales de AWS se configuran mediante variables de entorno:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION` (por defecto us-east-1)

## Testing

Ejecutar pruebas de aceptación:
```bash
cd tests/acceptance
terraform test
```
<<<
END FILE>>>
```
