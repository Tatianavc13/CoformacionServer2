#!/bin/bash

# Script para configurar y subir proyecto a GitHub
# Repositorio: ConformacionServer (privado)
# Usuario: AngelOso20

echo "🚀 Configurando GitHub para Sistema Coformación"
echo "================================================"

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para mostrar mensajes
show_message() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

show_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

show_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

show_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Verificar que estamos en el directorio correcto
if [ ! -f "package.json" ] || [ ! -d "backendCoformacion" ]; then
    show_error "Este script debe ejecutarse desde el directorio raíz del proyecto"
    exit 1
fi

# Verificar si Git está instalado
if ! command -v git &> /dev/null; then
    show_error "Git no está instalado. Por favor instálalo primero."
    exit 1
fi

# Verificar si GitHub CLI está instalado
if ! command -v gh &> /dev/null; then
    show_warning "GitHub CLI no está instalado. Instalando..."
    
    # Instalar GitHub CLI según el sistema operativo
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
        sudo apt update
        sudo apt install gh
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install gh
    else
        show_error "Sistema operativo no soportado para instalación automática de GitHub CLI"
        exit 1
    fi
fi

# Configurar Git
show_message "Configurando Git..."
git config --global user.name "AngelOso20"
git config --global user.email "angeloso20@example.com"

# Inicializar repositorio Git
show_message "Inicializando repositorio Git..."
git init

# Crear archivo .gitignore
show_message "Creando archivo .gitignore..."
cat > .gitignore << 'EOF'
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
EOF

# Agregar archivos al repositorio
show_message "Agregando archivos al repositorio..."
git add .

# Hacer commit inicial
show_message "Haciendo commit inicial..."
git commit -m "🚀 Initial commit: Sistema de Coformación

- Frontend Angular 17.1.0
- Backend Django 5.2.3
- Base de datos MySQL 8.0
- Configuración para conformacion.twentybyte.com
- Scripts de despliegue incluidos
- Documentación completa"

# Configurar GitHub CLI
show_message "Configurando GitHub CLI..."
echo "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" | gh auth login --with-token

# Crear repositorio privado
show_message "Creando repositorio privado en GitHub..."
gh repo create ConformacionServer --private --description "Sistema de Coformación - Frontend Angular + Backend Django + MySQL" --source=. --remote=origin --push

# Verificar que el repositorio se creó correctamente
if [ $? -eq 0 ]; then
    show_success "✅ Repositorio creado exitosamente en GitHub"
    show_success "✅ Código subido a la rama principal"
    show_success "✅ Repositorio configurado como privado"
else
    show_error "❌ Error creando el repositorio en GitHub"
    exit 1
fi

# Mostrar información del repositorio
echo ""
echo "================================================"
show_success "🎉 Proyecto subido exitosamente a GitHub"
echo ""
echo "📱 Información del repositorio:"
echo "   Nombre: ConformacionServer"
echo "   Visibilidad: Privado"
echo "   URL: https://github.com/AngelOso20/ConformacionServer"
echo "   Rama principal: main"
echo ""
echo "📊 Archivos incluidos:"
echo "   ✅ Código fuente completo"
echo "   ✅ Configuración de producción"
echo "   ✅ Scripts de despliegue"
echo "   ✅ Documentación"
echo "   ✅ Archivos de configuración"
echo ""
echo "🔧 Comandos útiles:"
echo "   Ver repositorio: gh repo view AngelOso20/ConformacionServer"
echo "   Clonar: git clone https://github.com/AngelOso20/ConformacionServer.git"
echo "   Actualizar: git push origin main"
echo "================================================"
