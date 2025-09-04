#!/bin/bash

# Script de inicio para Sistema Coformación
# Dominio: conformacion.twentybyte.com
# Puertos: Angular 4201, Django 8001

echo "🚀 Iniciando Sistema Coformación - conformacion.twentybyte.com"
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

# Verificar que estamos en el directorio correcto
if [ ! -f "package.json" ] || [ ! -d "backendCoformacion" ]; then
    show_error "Este script debe ejecutarse desde el directorio raíz del proyecto"
    exit 1
fi

# Verificar si los procesos ya están ejecutándose
if pgrep -f "ng serve" > /dev/null; then
    show_warning "Angular ya está ejecutándose en puerto 4201"
else
    show_message "Iniciando Angular en puerto 4201..."
    ng serve --port 4201 --host 0.0.0.0 &
    ANGULAR_PID=$!
    show_success "Angular iniciado con PID: $ANGULAR_PID"
fi

if pgrep -f "python.*manage.py.*runserver" > /dev/null; then
    show_warning "Django ya está ejecutándose en puerto 8001"
else
    show_message "Iniciando Django en puerto 8001..."
    cd backendCoformacion
    source venv/bin/activate 2>/dev/null || python3 -m venv venv && source venv/bin/activate
    pip install -r requirements.txt > /dev/null 2>&1
    python manage.py migrate --settings=backend_uniempresarial.settings_prod
    python manage.py collectstatic --noinput --settings=backend_uniempresarial.settings_prod
    python manage.py runserver 0.0.0.0:8001 --settings=backend_uniempresarial.settings_prod &
    DJANGO_PID=$!
    cd ..
    show_success "Django iniciado con PID: $DJANGO_PID"
fi

# Esperar un momento para que los servicios se inicien
sleep 3

# Verificar que los servicios estén funcionando
show_message "Verificando servicios..."

# Verificar Angular
if curl -s http://localhost:4201 > /dev/null; then
    show_success "✅ Angular funcionando en http://localhost:4201"
else
    show_error "❌ Angular no responde en puerto 4201"
fi

# Verificar Django
if curl -s http://localhost:8001/api/estudiantes/ > /dev/null; then
    show_success "✅ Django funcionando en http://localhost:8001"
else
    show_error "❌ Django no responde en puerto 8001"
fi

echo ""
echo "================================================================"
show_success "🎉 Sistema Coformación iniciado correctamente"
echo ""
echo "📱 URLs de acceso:"
echo "   Frontend: http://localhost:4201"
echo "   Backend API: http://localhost:8001/api"
echo "   Admin Django: http://localhost:8001/admin"
echo ""
echo "🌐 Para producción con Nginx:"
echo "   Aplicación: https://conformacion.twentybyte.com"
echo "   API: https://conformacion.twentybyte.com/api"
echo ""
echo "🔧 Para detener los servicios:"
echo "   ./stop-conformacion.sh"
echo "================================================================"
