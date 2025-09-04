# Script PowerShell simplificado para configurar GitHub
# Repositorio: ConformacionServer (privado)
# Usuario: AngelOso20

Write-Host "🚀 Configurando GitHub para Sistema Coformación" -ForegroundColor Blue
Write-Host "================================================" -ForegroundColor Blue

# Verificar que estamos en el directorio correcto
if (-not (Test-Path "package.json") -or -not (Test-Path "backendCoformacion")) {
    Write-Host "[ERROR] Este script debe ejecutarse desde el directorio raíz del proyecto" -ForegroundColor Red
    exit 1
}

# Verificar si Git está instalado
try {
    git --version | Out-Null
    Write-Host "[SUCCESS] Git está instalado" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Git no está instalado. Por favor instálalo primero desde https://git-scm.com/" -ForegroundColor Red
    exit 1
}

# Configurar Git
Write-Host "[INFO] Configurando Git..." -ForegroundColor Blue
git config --global user.name "AngelOso20"
git config --global user.email "angeloso20@example.com"

# Inicializar repositorio Git
Write-Host "[INFO] Inicializando repositorio Git..." -ForegroundColor Blue
git init

# Crear archivo .gitignore
Write-Host "[INFO] Creando archivo .gitignore..." -ForegroundColor Blue
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
Write-Host "[INFO] Agregando archivos al repositorio..." -ForegroundColor Blue
git add .

# Hacer commit inicial
Write-Host "[INFO] Haciendo commit inicial..." -ForegroundColor Blue
git commit -m "🚀 Initial commit: Sistema de Coformación

- Frontend Angular 17.1.0
- Backend Django 5.2.3
- Base de datos MySQL 8.0
- Configuración para conformacion.twentybyte.com
- Scripts de despliegue incluidos
- Documentación completa"

# Configurar GitHub CLI
Write-Host "[INFO] Configurando GitHub CLI..." -ForegroundColor Blue
$env:GITHUB_TOKEN = "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"

# Crear repositorio privado
Write-Host "[INFO] Creando repositorio privado en GitHub..." -ForegroundColor Blue
gh repo create ConformacionServer --private --description "Sistema de Coformación - Frontend Angular + Backend Django + MySQL" --source=. --remote=origin --push

# Verificar que el repositorio se creó correctamente
if ($LASTEXITCODE -eq 0) {
    Write-Host "[SUCCESS] ✅ Repositorio creado exitosamente en GitHub" -ForegroundColor Green
    Write-Host "[SUCCESS] ✅ Código subido a la rama principal" -ForegroundColor Green
    Write-Host "[SUCCESS] ✅ Repositorio configurado como privado" -ForegroundColor Green
} else {
    Write-Host "[ERROR] ❌ Error creando el repositorio en GitHub" -ForegroundColor Red
    exit 1
}

# Mostrar información del repositorio
Write-Host ""
Write-Host "================================================" -ForegroundColor Blue
Write-Host "[SUCCESS] 🎉 Proyecto subido exitosamente a GitHub" -ForegroundColor Green
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
