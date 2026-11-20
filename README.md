# Aprovisionamiento de Infraestructura con Terraform para el Servicio de Ordenes

El servicio de ordenes requiere una infraestructura robusta y versionada para su operación. Utilizando Terraform, debes aprovisionar la infraestructura AWS necesaria, separando los módulos por red, computo y base de datos. El estado remoto de Terraform se guardará en un backend S3 declarado en el código de infraestructura. No se permitirá el uso de Lombok en el código Java.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | Infraestructura como codigo para el servicio de ordenes |
| **Nivel** | senior-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 8 horas |

## Stack

- **Lenguaje:** Terraform
- **Framework:** AWS Provider
- **Version:** 5.0

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Tener el proyecto base del reto funcionando en tu máquina: clonar el repositorio, instalar las herramientas y verificar que compila y arranca antes de empezar a practicar.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Instala las herramientas para ejecutar el proyecto: Terraform 1.5+.
- Clona el repositorio del reto (el enlace viene en la entrega del reto y en la sección "Repositorio del Proyecto" del PDF) y ábrelo en tu IDE.
- Instala las dependencias y compila ejecutando `terraform init -backend=false && terraform -chdir=environments init -backend=false && terraform -chdir=modules/compute init -backend=false && terraform -chdir=modules/database init -backend=false && terraform -chdir=modules/network init -backend=false && terraform validate && terraform -chdir=environments validate && terraform -chdir=modules/compute validate && terraform -chdir=modules/database validate && terraform -chdir=modules/network validate` en la raíz del repositorio.
- Confirma que el comando termina sin errores: el proyecto arranca y sus pruebas corren.
- Ubica los archivos de práctica: son los que contienen `TODO(reto)` (búscalos en el repositorio). Lee el README.md y el AGENTS.md antes de empezar.

**Entregable:** El proyecto compila/arranca sin errores con `terraform init -backend=false && terraform -chdir=environments init -backend=false && terraform -chdir=modules/compute init -backend=false && terraform -chdir=modules/database init -backend=false && terraform -chdir=modules/network init -backend=false && terraform validate && terraform -chdir=environments validate && terraform -chdir=modules/compute validate && terraform -chdir=modules/database validate && terraform -chdir=modules/network validate`.

<details>
<summary>Pistas de conocimiento</summary>

- Los archivos con `TODO(reto)` son el ejercicio: el resto del repositorio ya está resuelto y no hace falta tocarlo.
- Si el comando de verificación falla, revisa la versión de las herramientas instaladas antes de modificar código.
- AGENTS.md describe el reto, el comando de verificación y las reglas del repositorio.

</details>

### Fase 1: Configuración Inicial de Terraform

**Objetivo:** Configurar el entorno de Terraform y separar los módulos por red, computo y base de datos.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Crear la estructura de directorios para los módulos de Terraform.
- Configurar el backend remoto de Terraform en S3.
- Asegurarse de que no se use Lombok en el código Java.

**Entregable:** Estructura de directorios de Terraform con módulos separados y backend remoto configurado.

<details>
<summary>Pistas de conocimiento</summary>

- Terraform permite la gestión de infraestructura como código.
- Los módulos de Terraform ayudan a organizar y reutilizar código.

</details>

### Fase 2: Desarrollo de Módulos de Terraform

**Objetivo:** Desarrollar los módulos de Terraform para red, computo y base de datos.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Crear los archivos de Terraform para cada módulo.
- Definir los recursos necesarios para cada módulo.
- Asegurarse de que los módulos sean reutilizables y mantenibles.

**Entregable:** Módulos de Terraform desarrollados para red, computo y base de datos.

<details>
<summary>Pistas de conocimiento</summary>

- Los recursos de Terraform permiten la creación y gestión de infraestructura.
- Los módulos de Terraform deben ser reutilizables y mantenibles.

</details>

### Fase 3: Aprovisionamiento de Infraestructura

**Objetivo:** Aprovisionar la infraestructura AWS utilizando los módulos de Terraform desarrollados.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Aprovisionar la infraestructura utilizando los módulos de Terraform.
- Documentar la infraestructura aprovisionada.

**Entregable:** Infraestructura AWS aprovisionada y documentada.

<details>
<summary>Pistas de conocimiento</summary>

- Los comandos de Terraform permiten la ejecución y gestión de la infraestructura.
- La documentación del proceso de aprovisionamiento ayuda a la mantenibilidad y reutilización del código.

</details>

### Fase 4: Validación y Optimización

**Objetivo:** Validar el funcionamiento de la infraestructura y optimizar los módulos de Terraform.

**Tiempo estimado:** 1 hora

**Instrucciones:**

- Realizar pruebas de integración para validar el funcionamiento de la infraestructura.
- Identificar áreas de mejora en los módulos de Terraform.
- Optimizar los módulos de Terraform para mejorar la eficiencia y mantenibilidad.

**Entregable:** Infraestructura validada y módulos de Terraform optimizados.

<details>
<summary>Pistas de conocimiento</summary>

- Las pruebas de integración ayudan a validar el funcionamiento de la infraestructura.
- La optimización de los módulos de Terraform mejora la eficiencia y mantenibilidad del código.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es Terraform y cómo se utiliza para aprovisionar infraestructura?
- **paraQueSirve**: ¿Para qué sirve separar los módulos de Terraform por red, computo y base de datos?
- **comoSeUsa**: ¿Cómo se utilizan los comandos de Terraform para aprovisionar la infraestructura?
- **erroresComunes**: ¿Cuáles son los errores comunes al aprovisionar infraestructura con Terraform y cómo se pueden evitar?
- **queDecisionesImplica**: ¿Qué decisiones se deben tomar al optimizar los módulos de Terraform?

## Criterios de Evaluacion

- Configuración inicial de Terraform con módulos separados y backend remoto configurado.
- Desarrollo de módulos de Terraform para red, computo y base de datos.
- Aprovisionamiento de infraestructura AWS utilizando los módulos de Terraform desarrollados.
- Validación del funcionamiento de la infraestructura y optimización de los módulos de Terraform.

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

## Pruebas de aceptacion

Las pruebas de aceptacion (columna "Prueba" de la tabla) son de **solo lectura**: definen que significa "listo". No las edites, no las borres y no les agregues `skip`; lo que se resuelve es el codigo de cada pieza.

## Restricciones del pedido

| Restriccion | Donde se cumple | Estado |
|-------------|-----------------|--------|
| Usar modulos de Terraform separados por red, computo y base de datos (un directorio por modulo) | chequeo estatico (manifest): prohibe `module.network`, `module.compute`, `module.database` | Verificada |
| No usar Lombok en el codigo Java | chequeo estatico (code): prohibe `Lombok` | Verificada |
| Guardar el estado remoto de Terraform en un backend S3 declarado en el codigo de infraestructura | `environments/optimize.tf:aws_s3_bucket.terraform_state` | Verificada |

## Herramientas

- **Java**: Tecnologia pedida para este reto: forma parte del stack con el que se resuelve el ejercicio.

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
terraform init -backend=false && terraform -chdir=environments init -backend=false && terraform -chdir=modules/compute init -backend=false && terraform -chdir=modules/database init -backend=false && terraform -chdir=modules/network init -backend=false && terraform validate && terraform -chdir=environments validate && terraform -chdir=modules/compute validate && terraform -chdir=modules/database validate && terraform -chdir=modules/network validate
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
