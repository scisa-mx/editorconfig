# CONTEXT — SCISA Org Guidelines

## Propósito de este repositorio

Este repositorio **formaliza prácticas que ambos equipos ya comparten** en un formato conocido para el desarrollador. El objetivo es estandarizar organization-wide lo que hoy existe de forma implícita o inconsistente entre DevHub e Innovación.

**Estado actual de gobernanza:** No existe un proceso formal definido de quién aprueba cambios a los lineamientos ni quién los hace cumplir. Se reconoce la necesidad de un comité entre ambos equipos técnicos.

---

## Organización

**SCISA** es una empresa de servicios de TI para el **sector financiero** en México. Cuenta con dos equipos de desarrollo:

- **DevHub** — equipo de Operaciones (mantiene y opera los productos existentes)
- **Innovación** — equipo enfocado en nuevos desarrollos y la transición SaaS

Actualmente no hay mecanismos formales de cohesión entre equipos. Se ha identificado la necesidad de un comité técnico conjunto que garantice la adopción consistente de lineamientos.

 Sus dos productos principales son:

- **SIGLO CD** — Sistema de Cambio de Divisas. Cada cliente tiene su propia versión con personalizaciones específicas — en la práctica, cada instalación es una variante distinta del mismo producto.
- **SIGLO PLD** — Sistema de Prevención de Lavado de Dinero. Nació del mismo core que SIGLO CD, pero dado que tiene más clientes y las personalizaciones son menos profundas, se tomó la decisión de mantener una **versión Tronco** compartida para todos los clientes. Si un cliente requiere personalización profunda, se le vende una versión **Enterprise** (fork dedicado).

La dirección estratégica actual es migrar de deployments **on-premise** a un modelo **SaaS** en la nube.

### Modelo de personalización por cliente (SIGLO CD)

Cada cliente de SIGLO CD es un fork de la solución base. Con el tiempo, las versiones divergen lo suficiente para que no sean el mismo producto en la práctica. Las versiones se identifican por el nombre del cliente (ej. BANCREA, ACTINVER, BAJIO).

**Problema operacional conocido:** Hoy no existe un mecanismo claro para compartir funcionalidad entre forks. Los cambios se propagan copiando código, sin criterios explícitos de cuándo y cómo migrar, ni condiciones para validar que la migración está completa y correcta. Esta es una oportunidad de mejora identificada pero aún sin solución definida.

---

## Dos tracks tecnológicos

### Track Legacy (on-premise)

- Backend: .NET Framework 4.8 / 4.5, WCF
- Frontend: WPF; algunos aplicativos PLD usan MVC 5 + Blazor
- Base de datos: MSSQL (mayoría), Oracle (algunos clientes)
- Infraestructura: Windows Server + IIS
- Modelo: instalación por cliente

### Track SaaS (cloud — en adopción)

- Backend: .NET Core
- Frontend: Vue 3
- Mensajería async: RabbitMQ
- Caché: Redis
- Base de datos: MSSQL
- Infraestructura: contenedores serverless en Google Cloud Run
- Modelo: multi-tenant

---

## Roles

| Rol | Responsabilidad clave |
|---|---|
| **Junior** | Aplica lineamientos con supervisión, pregunta antes de decidir |
| **Mid** | Opera con autonomía, revisa PRs, gestiona deuda técnica, mentorea juniors |
| **Senior** | Diseña soluciones, lidera code reviews, último filtro de calidad antes de producción |
| **Tech Lead / Arquitecto** | Define dirección técnica, aprueba dependencias, escala decisiones de arquitectura |
| **PM (Product Manager)** | Aprueba releases, coordina notificación a clientes, co-firma gateway de producción |
| **Analista de Negocio / PO** | Entrega tickets con criterios de aceptación claros antes del sprint (DoR) |
| **QA / Tester** | Valida criterios de aceptación, documenta casos reproducibles |

---

## Gitflow (versión extendida)

SCISA usa una variante de Gitflow con soporte para versiones múltiples simultáneas de clientes.

### Ramas long-lived

| Rama | Propósito |
|---|---|
| `master` | Producción. Solo recibe merges desde `releases/*`. Cada nodo = versión etiquetada. Todo lo que llega al cliente sale de aquí. |
| `development` | Integración. Acumula features completos. Estable pero puede contener funcionalidad no lista para producción. |

> **Nota:** La convención actual usa `development`. Se ha propuesto estandarizar a `develop` para alinearse con Gitflow canónico — decisión pendiente.

### Ramas short-lived

| Rama | Propósito | Origen | Destino |
|---|---|---|---|
| `features/<ticket>_<nombre>` | Desarrollar una funcionalidad específica | `development` | `development` vía PR |
| `releases/v<version>` | Preparar un release: QA final, bug fixes, ajustes del cliente | `development` | `master` + `development` |
| `hotfixes/<ticket>_<nombre>` | Fix crítico en producción que no puede esperar al próximo release | `master` | `master` + rebase a `development` |
| `STS/v<version>` | Short Term Support: soporte a versión activa del cliente cuando ya existe versión nueva en master. Principalmente SIGLO CD. | tag en `master` | `master` + `development` |
| `LTS/*` | Long Term Support: soporte prolongado a versión estable sin agregar funcionalidad. Principalmente SIGLO PLD Tronco, donde múltiples clientes comparten la misma base y se necesita dar soporte a versiones anteriores sin incorporar features nuevos. | tag en `master` | — |

### Regla fundamental

**Todo lo que llega al cliente sale de `master`** — incluyendo ambientes de QA del cliente. Nunca se libera desde `releases/*` directamente al cliente.

---

## Versionamiento semántico

Formato: `MAJOR.MINOR.PATCH`

| Segmento | Cuándo incrementa |
|---|---|
| MAJOR | Cambio incompatible (rompe contrato público, elimina endpoints) |
| MINOR | Funcionalidad nueva compatible con lo existente |
| PATCH | Bug fix, mejora de rendimiento sin cambio de comportamiento |

- Cada versión en `master` lleva un **tag** (`v1.14.0`).
- Todo PR debe declarar el impacto de versión (PATCH / MINOR / MAJOR) con justificación.
- Los commits ayudan a inferir la versión pero no la sustituyen.

---

## Commits

Formato estándar (Conventional Commits):

```
<tipo>(<scope>): <mensaje corto>
```

| Tipo | Uso | Aparece en CHANGELOG |
|---|---|---|
| `feat` / `add` | Nueva funcionalidad | Sí |
| `fix` | Corrección de bug | Sí |
| `perf` | Mejora de rendimiento visible al usuario | Sí |
| `security` | Corrección de vulnerabilidad | Sí |
| `refactor` | Cambio interno sin impacto en comportamiento | No |
| `test` | Tests nuevos o ajustados | No |
| `docs` | Documentación | No |
| `chore` | Tareas técnicas sin impacto funcional | No |
| `bump` | Actualización de dependencias o versión | No |

> **Deuda conocida:** Este repo (`org-guidelines`) usa un formato no estándar (`ADD(scope): ...`). Debe migrarse al formato de Conventional Commits definido en `06.3.commits_rules.md`.

---

## Ambientes (modelo SaaS)

Flujo de promoción: `Local → Dev → Staging → Production`

| Ambiente | Audiencia | Estabilidad esperada |
|---|---|---|
| `dev` | Solo equipo técnico | Baja — ambiente de trabajo activo |
| `staging` | Equipo técnico + QA interno | Alta — si está roto, nadie avanza a producción |
| `production` | Clientes (tenants productivos y de prueba) | Máxima |

### Tenant

Una instancia de cliente dentro del sistema SaaS. Puede ser:
- **Tenant productivo** — operación real del cliente
- **Tenant de pruebas** — cliente piloto o early adopter; opera dentro de Producción, no en un ambiente separado

### Gateway de producción

Checklist que debe estar 100% verde antes de deployar a producción. Lo co-firman el **Lead Técnico** y el **PM**. Un solo No-Go bloquea el deploy.

### Ventana de deploy

Deploys a producción: **lunes a jueves, después de las 8:00 pm CST**.

Excepciones solo para hotfix crítico (seguridad o bug bloqueante) con aprobación explícita de Lead Técnico + PM.

---

## Glosario

| Término | Definición |
|---|---|
| **PR (Pull Request)** | Intención formal de integrar una rama en otra. Los commits cuentan el *cómo*; el PR explica el *por qué*. |
| **DoR (Definition of Ready)** | Criterios que debe cumplir un ticket antes de entrar al sprint. Responsabilidad del Analista / PO. |
| **DoD (Definition of Done)** | Criterios que debe cumplir una funcionalidad para considerarse terminada. Dos niveles: (1) criterios de aceptación del ticket verificados con evidencia, (2) criterios técnicos universales del equipo. Ver `05.5.DoD.md`. |
| **AC (Criterios de Aceptación)** | Lista de condiciones verificables "Check / No Check" que debe cumplir un ticket para considerarse terminado. Se definen antes de iniciar desarrollo (ver DoR `05.3.DoD.md`). Un ticket con ACs parcialmente cubiertos no está Done. |
| **Deuda técnica** | Trabajo pendiente de calidad que se acumula cuando se toman atajos. Se gestiona como parte del backlog, no como ruido de fondo. |
| **ADR (Architecture Decision Record)** | Documento que registra una decisión arquitectónica significativa: contexto, alternativas consideradas y razón de la elección. |
| **Tronco** | Versión base de SIGLO PLD compartida por todos los clientes estándar. Término interno oficial. Se mantiene como rama LTS cuando se requiere soporte prolongado sin agregar funcionalidad nueva. Contrasta con versión **Enterprise** (fork personalizado por cliente). |
| **Enterprise** | Versión personalizada de SIGLO PLD para un cliente específico con requerimientos que no caben en Tronco. Mismo modelo de personalización que SIGLO CD. |
| **Commit atómico** | Commit que compila, pasa tests y no deja el sistema en estado inconsistente. No mezcla responsabilidades. |
| **Gateway de producción** | Checklist formal de criterios Go/No-Go que debe cumplirse antes de cualquier deploy a producción. Lo co-firman Lead Técnico y PM. |
| **Gateway de entrega** | Checkpoint formal de validación previo al merge de un release a `master`. Lo ejecuta el TL responsable de la comunicación con el cliente —independiente del equipo que desarrolló— sobre ambiente publicado de QA, con demo en vivo. Requiere match en tres puntas: propuesta ↔ documentación ↔ entregable. Un solo punto de desalineación es No-Go. Ver `05.12.delivery_gateway.md`. |
| **Incidencia de gateway** | Fallo detectado durante el Gateway de entrega (No-Go). Gravedad media: el sistema de control funcionó. Se registra en ClickUp con etapa de origen y causa raíz. |
| **Incidencia post-entrega** | Fallo detectado por el cliente después de que el release pasó el gateway. Gravedad alta: el gateway falló. Solo aplica si lo entregado contradice la propuesta aprobada — si el cliente pide algo nuevo, es cambio de alcance. Requiere análisis retrospectivo de causa raíz en máximo 5 días hábiles. |
| **Tasa de fallos de entrega** | KPI del proceso de entrega: intentos fallidos / total de intentos. Meta: aproximarse a 0%. Se desagrega por etapa de origen (Análisis / Desarrollo / Gateway) para identificar qué proceso mejorar. Revisión por release y trimestral. Ver `05.13.delivery_kpi.md`. |
| **Tenant de pruebas** | Instancia de cliente en Producción usada para validar features antes de activarlos en el tenant productivo. No es un ambiente separado. |
| **Wiki de cliente** | Sitio wiki.js por cliente on-premise. Fuente de verdad del estado AS-IS del cliente: arquitectura, versiones, manuales, ambientes SCISA. Reemplaza las bitácoras ad-hoc por TL. El cliente tiene acceso de lectura a manuales y estado de versiones; el resto es interno. Ver `07.7.client_wiki_standard.md`. |
| **Slug** | Identificador corto de cliente o servicio usado en subdominios. Reglas: minúsculas, alfanumérico + guión únicamente. Ej: `bancrea`, `api-pld`. |
| **Subdominio de servicio central** | Subdominio sin nivel de cliente: `<servicio>.<dominio>`. Aplica a servicios compartidos entre todos los tenants. |
| **Subdominio de cliente** | Subdominio con nivel de cliente: `<servicio>.<cliente>.<dominio>`. El slug del cliente no cambia entre ambientes. |
| **Ambiente QA** | Ambiente accesible por el cliente para validar antes de producción. Equivalente a staging internamente. En subdominios se identifica con el nivel `.qa.`: `<servicio>.<cliente>.qa.<dominio>`. |
| **Versión entregada** | Versión que SCISA envió formalmente al cliente. Puede ser más nueva que la versión en producción del cliente si el cliente aún no ha desplegado. |
| **Versión en producción del cliente** | Versión que el cliente tiene corriendo en su ambiente productivo. Solo se actualiza cuando el cliente confirma el deploy. Es el estado AS-IS — puede diferir de la versión entregada. |
| **Mirror productivo** | Ambiente de SCISA que replica el estado actual de producción del cliente on-premise. Se actualiza cuando el cliente confirma deploy a producción. Sirve para reproducir bugs y dar soporte sin tocar el ambiente del cliente. |
