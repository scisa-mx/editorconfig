# SCISA Claude Code Skills

Skills organizacionales para [Claude Code](https://claude.ai/code). Se instalan una vez y quedan disponibles en todos tus proyectos.

## Instalación

```powershell
irm https://raw.githubusercontent.com/scisa-mx/org-guidelines/main/install-skills.ps1 | iex
```

Requiere: Windows con PowerShell. No requiere npm ni clonar este repo.

Reinicia Claude Code después de instalar.

---

## Skills disponibles

### `scisa-changelog`

Genera entradas de `CHANGELOG.md` desde el historial de git, siguiendo el formato organizacional SCISA. Produce output en español listo para agregar al archivo.

**Uso en Claude Code:**

```
Genera el changelog de los commits desde el último release
```

```
Cierra el Unreleased como v2.1.0 con la fecha de hoy --write
```

Ver [estándar de releases](../docs/programming/0.7.repositories/07.2.releases.md) para referencia completa del formato.

---

### `ticket-template`

Crea tickets (Bug/Feature/Task/Spike/Epic) directo en ClickUp vía MCP, con la plantilla correcta según el tipo — sin repetir qué campos incluir cada vez. Independiente de `ticket-generator` (JSON para el widget de Tauri) y de `idea-sink` (sink de notas de Innovación).

**Uso en Claude Code:**

```
Crea un bug en ClickUp: el login falla en producción cuando el usuario usa SSO
```

```
Crea un epic para rediseñar el onboarding, con sus tickets hijos
```

---

## Agregar un skill nuevo

1. Crear directorio `skills/<nombre-del-skill>/`
2. Agregar `SKILL.md` con frontmatter y contenido del skill
3. Agregar el skill al array `$Skills` en `install-skills.ps1`
4. Actualizar este README con descripción y ejemplos de uso
