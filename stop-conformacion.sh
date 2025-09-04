#!/bin/bash

# Script para detener Sistema Coformación
# Dominio: conformacion.twentybyte.com

echo "🛑 Deteniendo Sistema Coformación - conformacion.twentybyte.com"
echo "================================================================"

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

# Detener Angular (puerto 4201)
show_message "Deteniendo Angular en puerto 4201..."
if pgrep -f "ng serve" > /dev/null; then
    pkill -f "ng serve"
    show_success "✅ Angular detenido"
else
    show_warning "Angular no estaba ejecutándose"
fi

# Detener Django (puerto 8001)
show_message "Deteniendo Django en puerto 8001..."
if pgrep -f "python.*manage.py.*runserver" > /dev/null; then
    pkill -f "python.*manage.py.*runserver"
    show_success "✅ Django detenido"
else
    show_warning "Django no estaba ejecutándose"
fi

# Verificar que los puertos estén libres
sleep 2

if ! pgrep -f "ng serve" > /dev/null && ! pgrep -f "python.*manage.py.*runserver" > /dev/null; then
    show_success "🎉 Sistema Coformación detenido correctamente"
    echo ""
    echo "📊 Estado de puertos:"
    echo "   Puerto 4201 (Angular): Libre"
    echo "   Puerto 8001 (Django): Libre"
else
    show_error "❌ Algunos procesos no se detuvieron correctamente"
    echo ""
    echo "🔧 Procesos restantes:"
    pgrep -f "ng serve" && echo "   Angular aún ejecutándose"
    pgrep -f "python.*manage.py.*runserver" && echo "   Django aún ejecutándose"
fi

echo "================================================================"
