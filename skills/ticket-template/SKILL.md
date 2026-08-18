---
name: ticket-template
description: >
  Genera y crea tickets directo en ClickUp vía MCP (Bug, Feature, Task, Spike, Epic),
  derivando los campos correctos según el tipo para que el usuario no tenga que
  repetirlos cada vez. Activar cuando el usuario pida crear, abrir o registrar un
  ticket, tarea, bug, feature, spike o epic en ClickUp de forma directa.
  Frases de activación: "crea un ticket en clickup para...", "abre un bug de...",
  "necesito una tarea para...", "crea un epic para...", "dame el ticket de...",
  "sube esto a clickup como ticket", "registra este bug en clickup".
  Independiente de ticket-widget (genera JSON para el widget de Tauri, no toca
  ClickUp) y de idea-sink (flujo del sink de notas de Innovación) — no se activa
  si el usuario pide explícitamente esos otros formatos.
---

# Ticket Template — ClickUp

Crea tickets directo en ClickUp vía MCP, con la plantilla correcta según el tipo. No es un formato JSON ni un flujo de sink — sube el ticket real usando `clickup_create_task`.

> Espacio-agnóstico: sirve para cualquier team/space (DevHub, Innovación, etc.), no está atado a una lista fija.

---

## Cuándo activar

Cuando el usuario pida crear un ticket/tarea/bug/feature/spike/epic en ClickUp directamente. Si pide explícitamente el JSON del widget → usa `ticket-widget`. Si pide capturar/procesar el sink de Innovación → usa `idea-sink`.

---

## Tipos de ticket y señales

| Tipo | Señales en el texto |
|---|---|
| **Bug** | "falla", "error", "no funciona", "rompe", "crash", "500" |
| **Feature** | "agregar", "necesitamos", "nueva pantalla", "el usuario debe poder", "quiero que" |
| **Task** | "configurar", "documentar", "actualizar dependencias", "migración", "script" |
| **Spike** | "investigar", "evaluar", "ver si vale la pena", "no sabemos cómo", "comparar" |
| **Epic** | "iniciativa", "proyecto grande", "conjunto de features/tickets", "roadmap", "épica" |

> ❌ No uses tipos fuera de estos cinco (ni "Improvement" ni "Refactor" — clasifica como Task).

Si el usuario nombra el tipo explícitamente, úsalo tal cual sin reinferir.

---

## Plantillas por tipo

### Bug
```markdown
**Comportamiento actual**
[Qué pasa hoy.]

**Comportamiento esperado**
[Qué debería pasar.]

**Pasos para reproducir**
1. [Paso 1]
2. [Paso 2]

**Entorno**
- Ambiente: [production / staging / local]
- Versión: [si aplica]

**Severidad:** [Critical / High / Medium / Low]

**Criterios de aceptación**
- [ ] El sistema se comporta como se esperaba
- [ ] El fix no rompe tests existentes
- [ ] Verificado en el ambiente donde se reportó
```

### Feature
```markdown
**Historia de usuario**
Como [rol], quiero [acción], para [beneficio].

**Descripción**
[Contexto de negocio y problema que resuelve.]

**Dependencias** *(si aplica)*
[Endpoints, equipos o tickets de los que depende.]

**Diseños/Mocks** *(si aplica)*
[Link a Figma/Adobe XD si hay UI involucrada.]

**Criterios de aceptación**
- [ ] [Condición verificable 1]
- [ ] [Condición verificable 2]

**Notas técnicas** *(si aplica)*
[Dependencias técnicas, APIs involucradas, consideraciones.]

**Datos de prueba** *(si aplica)*
[Qué datos/mocks se necesitan para probar escenarios reales.]
```

### Task
```markdown
**Descripción**
[Qué implica, por qué ahora, qué queda listo.]

**Dependencias** *(si aplica)*
[Qué necesita estar listo antes.]

**Criterios de aceptación**
- [ ] [Entregable concreto 1]
- [ ] [Entregable concreto 2]

**Notas técnicas** *(si aplica)*
[Herramientas, scripts o contexto relevante.]
```

### Spike
```markdown
**Pregunta a responder**
[La pregunta concreta que define el fin del spike.]

**Contexto**
[Por qué hay incertidumbre y qué se necesita saber para avanzar.]

**Timebox:** [ej. 1 día / 3 días]

**Entregable esperado:** [documento / ADR / POC / recomendación escrita]
```

### Epic
```markdown
**Objetivo**
[Por qué existe este epic — el problema u oportunidad de negocio.]

**Métrica de éxito**
[Cómo sabemos que el epic está cumplido.]

**Alcance**
- Dentro de alcance: [...]
- Fuera de alcance: [...]

**Tickets hijos**
- [ ] [ID/título del ticket 1]
- [ ] [ID/título del ticket 2]

**Timeline aproximado**
[Milestones o fechas objetivo, si existen.]
```

---

## Proceso

### 1. Clasificar
Si el usuario nombra el tipo, úsalo. Si no, infiere con la tabla de señales.

### 2. Completar campos requeridos
Si falta información necesaria para el tipo (p.ej. un Bug sin pasos de reproducir, un Feature sin historia de usuario clara), **pregunta al usuario** — no inventes contenido. Este skill corre en vivo/interactivo, a diferencia de `idea-sink` que procesa notas cortas en batch.

Campos marcados *(si aplica)* son opcionales — inclúyelos solo si hay información real, no los dejes como placeholder vacío.

### 3. Construir el ticket
- **Título**: máx. 10 palabras, imperativo, sin punto final.
- **Descripción**: markdown de la plantilla del tipo.
- **Prioridad**: `urgent` / `high` / `normal` / `low` — default `normal` salvo que el usuario indique otra.
- **Tags**: tipo en lowercase (`bug`, `feature`, `task`, `spike`, `epic`) + tags adicionales inferidos del contexto.
- ❌ No asignes personas ni estimes story points/horas salvo que el usuario lo pida explícitamente.

### 4. Confirmar destino
Pregunta a qué lista/space de ClickUp sube el ticket si no es obvio por la conversación:
> "¿A qué lista de ClickUp subo esto?"

Resuelve nombre/ID con `clickup_get_workspace_hierarchy` o `clickup_get_list` antes de crear. Si es ambiguo, repregunta hasta tener un ID concreto.

Muestra el ticket completo (título, tipo, prioridad, descripción, tags) y pregunta:
> "¿Todo se ve bien? ¿Cambio algo antes de subirlo?"

Espera confirmación.

### 5. Crear en ClickUp
Usa `clickup_create_task` con:
- `name` = título
- `markdown_description` = cuerpo de la plantilla
- `priority` = según el paso 3
- `tags` = según el paso 3

### 6. Caso Epic — tickets hijos
Después de crear el epic, pregunta:
> "¿Creo los tickets hijos ahora o los vinculamos después?"

Si ahora: repite este mismo proceso (pasos 1-5) por cada ticket hijo, luego:
- Vincúlalo al epic con `clickup_add_task_link`.
- Actualiza el checklist "Tickets hijos" del epic con `clickup_update_task`.

### 7. Confirmar al usuario
```
✅ Ticket creado: [Tipo] — [Título] → [url]
```

Para un epic con hijos creados en la misma sesión, lista también cada hijo:
```
✅ Epic creado: [Título] → [url]
   Hijos:
   - [Tipo] [Título] → [url]
   ...
```

---

## Notas generales

- No asignar personas ni estimar horas/story points salvo pedido explícito del usuario.
- No inventar pasos de reproducción, criterios de aceptación ni historias de usuario — preguntar si falta información.
- Este skill no reemplaza `ticket-widget` (JSON para el widget Tauri) ni `idea-sink` (sink de Innovación); son flujos independientes.
