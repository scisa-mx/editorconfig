# SCISA Claude Code Skills Installer
# Instala los skills de SCISA en el directorio global de Claude Code.
# Uso: irm https://raw.githubusercontent.com/scisa-mx/org-guidelines/main/install-skills.ps1 | iex

$ErrorActionPreference = "Stop"

$BaseUrl  = "https://raw.githubusercontent.com/scisa-mx/org-guidelines/main/skills"
$SkillsDir = Join-Path $env:USERPROFILE ".claude\skills"

$Skills = @(
    @{
        Name        = "scisa-changelog"
        Description = "Genera entradas de CHANGELOG siguiendo el formato organizacional SCISA"
        Files       = @("SKILL.md")
    },
    @{
        Name        = "ticket-generator"
        Description = "Genera tickets en formato JSON compacto para el widget Tauri de ClickUp"
        Files       = @("SKILL.md")
    },
    @{
        Name        = "idea-sink"
        Description = "Gestiona el idea sink de Innovación en ClickUp: captura notas/ideas en el inbox del doc y las procesa convirtiéndolas en tickets estructurados"
        Files       = @("SKILL.md")
    },
    @{
        Name        = "ticket-template"
        Description = "Plantilla y flujo para crear tickets (Bug/Feature/Task/Spike/Epic) directo en ClickUp vía MCP"
        Files       = @("SKILL.md")
    }
)

Write-Host ""
Write-Host "SCISA Claude Code Skills Installer" -ForegroundColor Cyan
Write-Host "===================================" -ForegroundColor Cyan
Write-Host ""

$Installed = 0
$Failed    = 0

foreach ($Skill in $Skills) {
    $SkillDir = Join-Path $SkillsDir $Skill.Name
    Write-Host "  Instalando: $($Skill.Name)" -NoNewline

    try {
        if (-not (Test-Path $SkillDir)) {
            New-Item -ItemType Directory -Path $SkillDir -Force | Out-Null
        }

        foreach ($File in $Skill.Files) {
            $Url      = "$BaseUrl/$($Skill.Name)/$File"
            $Dest     = Join-Path $SkillDir $File
            Invoke-WebRequest -Uri $Url -OutFile $Dest -UseBasicParsing
        }

        Write-Host " OK" -ForegroundColor Green
        Write-Host "     $($Skill.Description)" -ForegroundColor DarkGray
        $Installed++
    }
    catch {
        Write-Host " FALLO" -ForegroundColor Red
        Write-Host "     Error: $_" -ForegroundColor DarkGray
        $Failed++
    }
}

Write-Host ""
Write-Host "  Instalados : $Installed" -ForegroundColor Green
if ($Failed -gt 0) {
    Write-Host "  Fallidos   : $Failed" -ForegroundColor Red
}
Write-Host ""
Write-Host "Reinicia Claude Code para activar los skills." -ForegroundColor Yellow
Write-Host ""
