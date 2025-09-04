# Script PowerShell para configurar y subir proyecto a GitHub
# Repositorio: ConformacionServer (privado)
# Usuario: AngelOso20

Write-Host "🚀 Configurando GitHub para Sistema Coformación" -ForegroundColor Blue
Write-Host "================================================" -ForegroundColor Blue

# Función para mostrar mensajes
function Show-Message {
    param([string]$Message)
    Write-Host "[INFO] $Message" -ForegroundColor Blue
}

function Show-Success {
    param([string]$Message)
    Write-Host "[SUCCESS] $Message" -ForegroundColor Green
}

function Show-Warning {
    param([string]$Message)
    Write-Host "[WARNING] $Message" -ForegroundColor Yellow
}

function Show-Error {
    param([string]$Message)
    Write-Host "[ERROR] $Message" -ForegroundColor Red
}

# Verificar que estamos en el directorio correcto
if (-not (Test-Path "package.json") -or -not (Test-Path "backendCoformacion")) {
    Show-Error "Este script debe ejecutarse desde el directorio raíz del proyecto"
    exit 1
}

# Verificar si Git está instalado
try {
    git --version | Out-Null
    Show-Success "Git está instalado"
} catch {
    Show-Error "Git no está instalado. Por favor instálalo primero desde https://git-scm.com/"
    exit 1
}

# Verificar si GitHub CLI está instalado
try {
    gh --version | Out-Null
    Show-Success "GitHub CLI está instalado"
} catch {
    Show-Warning "GitHub CLI no está instalado. Instalando..."
    
    # Instalar GitHub CLI usando winget
    try {
        winget install --id GitHub.cli
        Show-Success "GitHub CLI instalado exitosamente"
    } catch {
        Show-Error "No se pudo instalar GitHub CLI automáticamente. Por favor instálalo manualmente desde https://cli.github.com/"
        exit 1
    }
}

# Configurar Git
Show-Message "Configurando Git..."
git config --global user.name "AngelOso20"
git config --global user.email "angeloso20@example.com"

# Inicializar repositorio Git
Show-Message "Inicializando repositorio Git..."
git init

# Crear archivo .gitignore
Show-Message "Creando archivo .gitignore..."
$gitignoreContent = @"
# Dependencies
node_modules/
backendCoformacion/venv/
backendCoformacion/__pycache__/
backendCoformacion/*/__pycache__/
backendCoformacion/*/migrations/__pycache__/

# Build outputs
dist/
build/

# Environment variables
.env
.env.local
.env.production

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Logs
*.log
logs/

# Database
*.db
*.sqlite3

# Python
*.pyc
*.pyo
*.pyd
__pycache__/
.Python
env/
venv/
ENV/
env.bak/
venv.bak/

# Django
*.log
local_settings.py
db.sqlite3
db.sqlite3-journal
media/

# Angular
.angular/
coverage/

# Temporary files
*.tmp
*.temp
"@

$gitignoreContent | Out-File -FilePath ".gitignore" -Encoding UTF8

# Agregar archivos al repositorio
Show-Message "Agregando archivos al repositorio..."
git add .

# Hacer commit inicial
Show-Message "Haciendo commit inicial..."
git commit -m "🚀 Initial commit: Sistema de Coformación

- Frontend Angular 17.1.0
- Backend Django 5.2.3
- Base de datos MySQL 8.0
- Configuración para conformacion.twentybyte.com
- Scripts de despliegue incluidos
- Documentación completa"

# Configurar GitHub CLI
Show-Message "Configurando GitHub CLI..."
$env:GITHUB_TOKEN = "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"
gh auth login --with-token

# Crear repositorio privado
Show-Message "Creando repositorio privado en GitHub..."
gh repo create ConformacionServer --private --description "Sistema de Coformación - Frontend Angular + Backend Django + MySQL" --source=. --remote=origin --push

# Verificar que el repositorio se creó correctamente
if ($LASTEXITCODE -eq 0) {
    Show-Success "✅ Repositorio creado exitosamente en GitHub"
    Show-Success "✅ Código subido a la rama principal"
    Show-Success "✅ Repositorio configurado como privado"
} else {
    Show-Error "❌ Error creando el repositorio en GitHub"
    exit 1
}

# Mostrar información del repositorio
Write-Host ""
Write-Host "================================================" -ForegroundColor Blue
Show-Success "🎉 Proyecto subido exitosamente a GitHub"
Write-Host ""
Write-Host "📱 Información del repositorio:" -ForegroundColor Cyan
Write-Host "   Nombre: ConformacionServer" -ForegroundColor White
Write-Host "   Visibilidad: Privado" -ForegroundColor White
Write-Host "   URL: https://github.com/AngelOso20/ConformacionServer" -ForegroundColor White
Write-Host "   Rama principal: main" -ForegroundColor White
Write-Host ""
Write-Host "📊 Archivos incluidos:" -ForegroundColor Cyan
Write-Host "   ✅ Código fuente completo" -ForegroundColor Green
Write-Host "   ✅ Configuración de producción" -ForegroundColor Green
Write-Host "   ✅ Scripts de despliegue" -ForegroundColor Green
Write-Host "   ✅ Documentación" -ForegroundColor Green
Write-Host "   ✅ Archivos de configuración" -ForegroundColor Green
Write-Host ""
Write-Host "🔧 Comandos útiles:" -ForegroundColor Cyan
Write-Host "   Ver repositorio: gh repo view AngelOso20/ConformacionServer" -ForegroundColor White
Write-Host "   Clonar: git clone https://github.com/AngelOso20/ConformacionServer.git" -ForegroundColor White
Write-Host "   Actualizar: git push origin main" -ForegroundColor White
Write-Host "================================================" -ForegroundColor Blue
