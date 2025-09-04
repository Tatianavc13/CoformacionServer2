# 🚀 Guía Manual para Subir Proyecto a GitHub

## 📋 Pasos para Subir el Proyecto a GitHub

### Paso 1: Configurar Git
```bash
git config --global user.name "AngelOso20"
git config --global user.email "angeloso20@example.com"
```

### Paso 2: Inicializar Repositorio
```bash
git init
```

### Paso 3: Crear .gitignore
Crear archivo `.gitignore` con el siguiente contenido:
```
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
```

### Paso 4: Agregar Archivos
```bash
git add .
```

### Paso 5: Hacer Commit
```bash
git commit -m "🚀 Initial commit: Sistema de Coformación

- Frontend Angular 17.1.0
- Backend Django 5.2.3
- Base de datos MySQL 8.0
- Configuración para conformacion.twentybyte.com
- Scripts de despliegue incluidos
- Documentación completa"
```

### Paso 6: Crear Repositorio en GitHub
1. Ir a https://github.com/new
2. Nombre del repositorio: `ConformacionServer`
3. Descripción: `Sistema de Coformación - Frontend Angular + Backend Django + MySQL`
4. Marcar como **Privado**
5. **NO** inicializar con README, .gitignore o licencia
6. Hacer clic en "Create repository"

### Paso 7: Conectar Repositorio Local con GitHub
```bash
git remote add origin https://github.com/AngelOso20/ConformacionServer.git
git branch -M main
git push -u origin main
```

### Paso 8: Verificar Subida
- Ir a https://github.com/AngelOso20/ConformacionServer
- Verificar que todos los archivos estén presentes
- Verificar que el repositorio sea privado

## 🔧 Comandos de GitHub CLI (Alternativa)

Si tienes GitHub CLI instalado:
```bash
# Autenticar
gh auth login --with-token < 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

# Crear repositorio
gh repo create ConformacionServer --private --description "Sistema de Coformación - Frontend Angular + Backend Django + MySQL" --source=. --remote=origin --push
```

## 📊 Verificación Final

Después de subir el proyecto, verificar:
- ✅ Repositorio creado como privado
- ✅ Todos los archivos subidos
- ✅ README.md visible
- ✅ .gitignore configurado
- ✅ Rama principal: main

## 🎯 Información del Repositorio

- **Nombre**: ConformacionServer
- **Visibilidad**: Privado
- **URL**: https://github.com/AngelOso20/ConformacionServer
- **Rama principal**: main
- **Propietario**: AngelOso20
