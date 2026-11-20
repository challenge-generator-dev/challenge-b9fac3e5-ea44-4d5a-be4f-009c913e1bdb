# AGENTS.md

Instrucciones para el agente de IA que abra este repositorio (Claude Code, Cursor, Codex, Copilot, Gemini). Se cargan solas: no hay que pegar nada en ningun chat.

## Que es este repositorio

Es el codigo base de un reto de aprendizaje de Pragma: **Aprovisionamiento de Infraestructura con Terraform para el Servicio de Ordenes**.

| | |
|---|---|
| Tema | Infraestructura como codigo para el servicio de ordenes |
| Nivel | senior-l2 |
| Chapter | Backend |
| Especialidad | Terraform (AWS) |
| Stack | Terraform / AWS Provider |
| Patron arquitectonico | modular con backend remoto S3 |
| Tiempo estimado | 8 horas |

## Herramientas

- **Java**: Tecnologia pedida para este reto: forma parte del stack con el que se resuelve el ejercicio.

## Receta del stack

Esqueleto obligatorio:

- `main.tf con los recursos`
- `variables.tf con las variables (sin default)`
- `outputs.tf con los valores expuestos`
- `versions.tf con required_version y required_providers`
- `environments/dev/terraform.tfvars con los valores`
- `README.md con la topologia y como validar (init -backend=false, validate)`

Trampas conocidas:

- NUNCA incluyas `apply`, `destroy` ni `deploy` (terraform apply/destroy, cdk deploy/destroy, sam deploy, aws cloudformation deploy) en README, scripts ni instrucciones: el reto se valida y se revisa, no se despliega.
- Cero credenciales hardcodeadas: nada de claves `AKIA...`, `aws_secret_access_key` ni `secret_key` literales. La autenticacion la resuelve el entorno del candidato (perfil o variables de entorno), nunca el codigo.
- Sin backend remoto real: nada de `backend "s3"` con un bucket concreto. Usa estado local (`backend "local"`) o no declares backend; la verificacion corre con `init -backend=false`.
- `versions.tf` declara `required_version` como RANGO (`>= 1.5`) y `required_providers` con `source = "hashicorp/aws"` y `version = "~> 5.0"` (una version que exista); nunca versiones exactas.
- Las variables de `variables.tf` NO llevan `default`: todos los valores van en `environments/dev/terraform.tfvars`.
- Para leer recursos que ya existen usa data sources (`aws_kms_key`, `aws_iam_role`, `aws_dynamodb_table`...) por nombre o alias, nunca `terraform_remote_state`.
- El codigo tiene que pasar `terraform fmt -check`: indentacion de 2 espacios y `=` alineados dentro de cada bloque.

## Tu tarea

Dejar este proyecto en estado **verificable**: que el comando de verificacion corra sin errores. Escribi los archivos en disco, en este repositorio. No generes ZIPs ni archivos adjuntos.

En orden:

1. Corre `terraform init -backend=false && terraform -chdir=environments init -backend=false && terraform -chdir=modules/compute init -backend=false && terraform -chdir=modules/database init -backend=false && terraform -chdir=modules/network init -backend=false && terraform validate && terraform -chdir=environments validate && terraform -chdir=modules/compute validate && terraform -chdir=modules/database validate && terraform -chdir=modules/network validate` y mira que falla.
2. Completa lo que falte de la lista de abajo: manifiesto de dependencias, punto de entrada, capa de interfaz y las capas del patron declarado.
3. Arregla SOLO los errores que impiden compilar o arrancar.
4. Volve a correr `terraform init -backend=false && terraform -chdir=environments init -backend=false && terraform -chdir=modules/compute init -backend=false && terraform -chdir=modules/database init -backend=false && terraform -chdir=modules/network init -backend=false && terraform validate && terraform -chdir=environments validate && terraform -chdir=modules/compute validate && terraform -chdir=modules/database validate && terraform -chdir=modules/network validate` hasta que pase.
5. Pará ahí.

## Regla dura: las fases son trabajo del humano

**PROHIBIDO implementar los entregables de las fases.** El valor del reto esta en que la persona los resuelva. Tu trabajo es que tenga un proyecto que arranca; el hueco pedagogico se queda como esta.

No resuelvas nada de esto:

- **Fase 1 — Configuración Inicial de Terraform**: Estructura de directorios de Terraform con módulos separados y backend remoto configurado.
- **Fase 2 — Desarrollo de Módulos de Terraform**: Módulos de Terraform desarrollados para red, computo y base de datos.
- **Fase 3 — Aprovisionamiento de Infraestructura**: Infraestructura AWS aprovisionada y documentada.
- **Fase 4 — Validación y Optimización**: Infraestructura validada y módulos de Terraform optimizados.

Distincion operativa:

- **Arreglar** (si): import faltante, tipo que no existe, dependencia sin declarar, error de sintaxis, archivo referenciado que no existe.
- **No tocar** (no): logica de negocio incompleta, validaciones ausentes, secretos hardcodeados, APIs deprecadas que funcionan, concurrencia insegura, patrones mejorables. Eso es lo que la persona tiene que encontrar.

## Superficie de practica (NO completes)

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs. No toques la logica que el reto pide completar.

- [ ] `environments/optimize.tf` — La pieza p1 (configuración de backend remoto de Terraform, fase f1) vive aqui: este archivo es su unico dueno (blueprint v2).
- [ ] `modules/network/vpc.tf` — La pieza p2 (configuración de red en AWS, fase f2) vive aqui: este archivo es su unico dueno (blueprint v2).
- [ ] `modules/compute/instance.tf` — La pieza p3 (configuración de instancias en AWS, fase f2) vive aqui: este archivo es su unico dueno (blueprint v2).
- [ ] `modules/database/rds.tf` — La pieza p4 (configuración de base de datos en AWS, fase f2) vive aqui: este archivo es su unico dueno (blueprint v2).

## Mapa de fases

La **Fase 0** es clonar el repositorio, instalar dependencias y correr las pruebas de aceptacion: todas fallan porque la logica de cada pieza esta pendiente.

| Fase | Pieza (skill) | Archivo:simbolo | Criterios | Prueba | Comando |
|------|---------------|-----------------|-----------|--------|---------|
| f1 — Configuración Inicial de Terraform | configuración de backend remoto de Terraform | `environments/optimize.tf:aws_s3_bucket.terraform_state` | La estructura de directorios de Terraform tiene módulos separados para red, computo y base de datos.; El backend remoto de Terraform está configurado y utiliza un bucket S3 para guardar el estado.; El backend remoto de Terraform no utiliza un bucket S3 inexistente.; El backend remoto de Terraform no utiliza una configuración inválida. | `tests/acceptance/f1.tftest.hcl` | `terraform test -test-directory=tests/acceptance -filter=tests/acceptance/f1.tftest.hcl` |
| f2 — Desarrollo de Módulos de Terraform | configuración de red en AWS | `modules/network/vpc.tf:aws_vpc.network` | El módulo de red de Terraform está desarrollado y configurado correctamente.; El módulo de computo de Terraform está desarrollado y configurado correctamente.; El módulo de base de datos de Terraform está desarrollado y configurado correctamente.; Los módulos de Terraform no utilizan una configuración inválida. | `tests/acceptance/f2.tftest.hcl` | `terraform test -test-directory=tests/acceptance -filter=tests/acceptance/f2.tftest.hcl` |
| f2 — Desarrollo de Módulos de Terraform | configuración de instancias en AWS | `modules/compute/instance.tf:aws_instance.compute` | El módulo de red de Terraform está desarrollado y configurado correctamente.; El módulo de computo de Terraform está desarrollado y configurado correctamente.; El módulo de base de datos de Terraform está desarrollado y configurado correctamente.; Los módulos de Terraform no utilizan una configuración inválida. | `tests/acceptance/f2.tftest.hcl` | `terraform test -test-directory=tests/acceptance -filter=tests/acceptance/f2.tftest.hcl` |
| f2 — Desarrollo de Módulos de Terraform | configuración de base de datos en AWS | `modules/database/rds.tf:aws_rds_instance.database` | El módulo de red de Terraform está desarrollado y configurado correctamente.; El módulo de computo de Terraform está desarrollado y configurado correctamente.; El módulo de base de datos de Terraform está desarrollado y configurado correctamente.; Los módulos de Terraform no utilizan una configuración inválida. | `tests/acceptance/f2.tftest.hcl` | `terraform test -test-directory=tests/acceptance -filter=tests/acceptance/f2.tftest.hcl` |
| f3 — Aprovisionamiento de Infraestructura | aprovisionamiento de infraestructura en AWS | — | La infraestructura AWS está aprovisionada correctamente.; La infraestructura AWS no está aprovisionada con una configuración inválida.; La infraestructura AWS no está aprovisionada con un módulo inexistente.; La infraestructura AWS no está aprovisionada con un error de Terraform. | `tests/acceptance/f3.tftest.hcl` | `terraform test -test-directory=tests/acceptance -filter=tests/acceptance/f3.tftest.hcl` |
| f4 — Validación y Optimización | validación y optimización de módulos de Terraform | — | La infraestructura AWS funciona correctamente.; Los módulos de Terraform están optimizados y no contienen configuraciones inválidas.; Los módulos de Terraform no contienen errores de sintaxis.; Los módulos de Terraform no contienen duplicados innecesarios. | `tests/acceptance/f4.tftest.hcl` | `terraform test -test-directory=tests/acceptance -filter=tests/acceptance/f4.tftest.hcl` |

## Pruebas de aceptacion y ubicacion de la logica

Las pruebas de aceptacion (columna "Prueba" de la tabla) son de **solo lectura**: definen que significa "listo". No las edites, no las borres y no les agregues `skip`; lo que se resuelve es el codigo de cada pieza.

La logica de cada pieza va en su archivo; no la muevas a otro.

## Restricciones del pedido

| Restriccion | Donde se cumple | Estado |
|-------------|-----------------|--------|
| Usar modulos de Terraform separados por red, computo y base de datos (un directorio por modulo) | chequeo estatico (manifest): prohibe `module.network`, `module.compute`, `module.database` | Verificada |
| No usar Lombok en el codigo Java | chequeo estatico (code): prohibe `Lombok` | Verificada |
| Guardar el estado remoto de Terraform en un backend S3 declarado en el codigo de infraestructura | `environments/optimize.tf:aws_s3_bucket.terraform_state` | Verificada |

## Lo que falta y tenes que completar

Referencias no verificadas para: .hcl. El analisis estatico no cubre esos lenguajes: que no se haya listado nada NO garantiza que no haya referencias colgando. Corre el comando de verificacion para encontrarlas.

### Presentes (16)

- `outputs.tf`
- `variables.tf`
- `versions.tf`
- `providers.tf`
- `environments/optimize.tf`
- `modules/network/vpc.tf`
- `modules/compute/instance.tf`
- `modules/database/rds.tf`
- `tests/acceptance/f1.tftest.hcl`
- `tests/acceptance/f2.tftest.hcl`
- `tests/acceptance/f3.tftest.hcl`
- `tests/acceptance/f4.tftest.hcl`
- `environments/dev/terraform.tfvars`
- `environments/backend.tf`
- `environments/main.tf`
- `README.md`

### Capas del patron declarado

Son las capas que la propuesta arquitectonica plantea, marcadas segun existan hoy en el repo. Orientan donde poner el codigo nuevo; no son una condicion para compilar.

- `modules/network` (presente)
- `modules/compute` (presente)
- `modules/database` (presente)
- `environments` (presente)

## Verificacion

```bash
terraform init -backend=false && terraform -chdir=environments init -backend=false && terraform -chdir=modules/compute init -backend=false && terraform -chdir=modules/database init -backend=false && terraform -chdir=modules/network init -backend=false && terraform validate && terraform -chdir=environments validate && terraform -chdir=modules/compute validate && terraform -chdir=modules/database validate && terraform -chdir=modules/network validate
```

El comando tiene que pasar SIN implementar los archivos de la superficie de practica: solo andamiaje.

Ese comando pasando es la definicion de "terminado" para vos.

## Convenciones que tenes que respetar

- Un solo ecosistema: no declares librerias de otro lenguaje ni mezcles gestores de paquetes.
- Toda libreria que uses tiene que estar declarada en el manifiesto de dependencias.
- Todo import declarado tiene que usarse; todo tipo usado tiene que existir o venir de una dependencia declarada.
- El patron es **modular con backend remoto S3**: los contratos (interfaces, puertos) los define la capa interna y los implementa la externa, nunca al revés.
- Los archivos que crees llevan implementacion real, no stubs: sin `TODO`, sin cuerpos vacios, sin `// getters y setters`.

## Contexto del candidato

Sirve para calibrar el nivel del codigo, no para resolver las fases.

- Perfil: Chapter Backend, Especialidad Desarrollador, Tecnología Java, Senior L2
- Brecha que el reto ataca: Aprovisionar infraestructura con Terraform
- Mision: Versionar la infraestructura del servicio

---

*Generado por Challenge Generator — Pragma. `README.md` tiene el enunciado completo del reto para la persona. `PROMPT_MEJORA.md` es la variante para pegar en un chat, si se prefiere ese flujo.*
