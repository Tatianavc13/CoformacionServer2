#!/bin/bash

echo "🚀 Iniciando Proyecto de Coformación"
echo "=================================="

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para mostrar estado
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Verificar si el directorio del backend existe
if [ ! -d "backendCoformacion" ]; then
    print_error "Directorio 'backendCoformacion' no encontrado!"
    exit 1
fi

# Verificar si package.json existe (proyecto Angular)
if [ ! -f "package.json" ]; then
    print_error "package.json no encontrado. ¿Estás en el directorio correcto del proyecto Angular?"
    exit 1
fi

print_status "Preparando el entorno..."

# Instalar dependencias de Angular si no existen
if [ ! -d "node_modules" ]; then
    print_status "Instalando dependencias de Angular..."
    npm install
    if [ $? -eq 0 ]; then
        print_success "Dependencias de Angular instaladas"
    else
        print_error "Error instalando dependencias de Angular"
        exit 1
    fi
else
    print_success "Dependencias de Angular ya están instaladas"
fi

# Verificar Python
if ! command -v python &> /dev/null; then
    if ! command -v python3 &> /dev/null; then
        print_error "Python no está instalado o no está en el PATH"
        exit 1
    else
        PYTHON_CMD="python3"
    fi
else
    PYTHON_CMD="python"
fi

print_success "Python encontrado: $PYTHON_CMD"

# Función para iniciar el backend
start_backend() {
    print_status "Iniciando backend Django..."
    cd backendCoformacion
    
    # Verificar si manage.py existe
    if [ ! -f "manage.py" ]; then
        print_error "manage.py no encontrado en backendCoformacion/"
        exit 1
    fi
    
    # Ejecutar migraciones
    print_status "Ejecutando migraciones..."
    $PYTHON_CMD manage.py migrate
    
    # Iniciar servidor Django
    print_success "Iniciando servidor Django en http://127.0.0.1:8000"
    $PYTHON_CMD manage.py runserver &
    DJANGO_PID=$!
    
    cd ..
    sleep 3
}

# Función para iniciar el frontend
start_frontend() {
    print_status "Iniciando frontend Angular..."
    
    # Verificar si Angular CLI está disponible
    if ! command -v ng &> /dev/null; then
        print_error "Angular CLI no está instalado. Instálalo con: npm install -g @angular/cli"
        exit 1
    fi
    
    print_success "Iniciando servidor Angular en http://localhost:4200"
    ng serve &
    ANGULAR_PID=$!
    
    sleep 3
}

# Función para verificar si los puertos están disponibles
check_ports() {
    # Verificar puerto 8000 (Django)
    if lsof -i:8000 &> /dev/null; then
        print_warning "Puerto 8000 ya está en uso. Django podría no iniciarse correctamente."
    fi
    
    # Verificar puerto 4200 (Angular)
    if lsof -i:4200 &> /dev/null; then
        print_warning "Puerto 4200 ya está en uso. Angular podría no iniciarse correctamente."
    fi
}

# Función de limpieza al salir
cleanup() {
    print_status "Deteniendo servidores..."
    if [ ! -z "$DJANGO_PID" ]; then
        kill $DJANGO_PID 2>/dev/null
        print_success "Servidor Django detenido"
    fi
    if [ ! -z "$ANGULAR_PID" ]; then
        kill $ANGULAR_PID 2>/dev/null
        print_success "Servidor Angular detenido"
    fi
    exit 0
}

# Configurar trap para limpieza
trap cleanup SIGINT SIGTERM

# Verificar puertos
check_ports

# Iniciar servicios
start_backend
start_frontend

# Mostrar información
echo ""
print_success "🎉 ¡Servidores iniciados exitosamente!"
echo ""
echo -e "${GREEN}Frontend Angular:${NC} http://localhost:4200"
echo -e "${GREEN}Backend Django:${NC}   http://127.0.0.1:8000"
echo -e "${GREEN}Admin Django:${NC}     http://127.0.0.1:8000/admin"
echo -e "${GREEN}API Endpoints:${NC}    http://127.0.0.1:8000/api/"
echo -e "${GREEN}Diagnóstico:${NC}      http://localhost:4200/diagnostico"
echo ""
print_status "Presiona Ctrl+C para detener ambos servidores"
echo ""

# Mantener el script ejecutándose
wait 