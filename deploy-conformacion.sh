#!/bin/bash

# Script de despliegue completo para conformacion.twentybyte.com
# Puertos: Angular 4201, Django 8001
# Base de datos: MySQL existente en puerto 3306
# Usuario: coformacion_user
# Contraseña: Coformacion2024#Secure

echo "🚀 Despliegue Sistema Coformación - conformacion.twentybyte.com"
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

# Crear directorio de producción
show_message "Creando estructura de directorios..."
sudo mkdir -p /var/www/conformacion
sudo chown -R $USER:$USER /var/www/conformacion

# Copiar archivos del proyecto
show_message "Copiando archivos del proyecto..."
cp -r . /var/www/conformacion/
cd /var/www/conformacion

# Configurar base de datos
show_message "Configurando base de datos MySQL..."
if mysql -u root -p < setup-database.sql; then
    show_success "✅ Base de datos configurada correctamente"
else
    show_error "❌ Error configurando base de datos"
    exit 1
fi

# Configurar backend Django
show_message "Configurando backend Django..."
cd backendCoformacion

# Crear entorno virtual
python3 -m venv venv
source venv/bin/activate

# Instalar dependencias
pip install -r requirements.txt

# Ejecutar migraciones
python manage.py migrate --settings=backend_uniempresarial.settings_prod

# Crear superusuario (opcional)
show_message "¿Deseas crear un superusuario? (y/n)"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    python manage.py createsuperuser --settings=backend_uniempresarial.settings_prod
fi

# Recopilar archivos estáticos
python manage.py collectstatic --noinput --settings=backend_uniempresarial.settings_prod

cd ..

# Configurar frontend Angular
show_message "Configurando frontend Angular..."
npm install
ng build --configuration production

# Configurar Nginx
show_message "Configurando Nginx..."
if [ -f "nginx-conformacion.conf" ]; then
    sudo cp nginx-conformacion.conf /etc/nginx/sites-available/conformacion
    sudo ln -sf /etc/nginx/sites-available/conformacion /etc/nginx/sites-enabled/
    sudo nginx -t
    if [ $? -eq 0 ]; then
        sudo systemctl reload nginx
        show_success "✅ Nginx configurado correctamente"
    else
        show_error "❌ Error en configuración de Nginx"
        exit 1
    fi
else
    show_error "❌ Archivo nginx-conformacion.conf no encontrado"
    exit 1
fi

# Crear servicio systemd para Django
show_message "Creando servicio systemd para Django..."
sudo tee /etc/systemd/system/conformacion.service > /dev/null <<EOF
[Unit]
Description=Conformacion Django App
After=network.target

[Service]
User=www-data
Group=www-data
WorkingDirectory=/var/www/conformacion/backendCoformacion
Environment="PATH=/var/www/conformacion/backendCoformacion/venv/bin"
ExecStart=/var/www/conformacion/backendCoformacion/venv/bin/gunicorn --bind 127.0.0.1:8001 --workers 3 backend_uniempresarial.wsgi:application
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Habilitar y iniciar servicio
sudo systemctl daemon-reload
sudo systemctl enable conformacion
sudo systemctl start conformacion

# Verificar servicios
show_message "Verificando servicios..."

# Verificar Django
if systemctl is-active --quiet conformacion; then
    show_success "✅ Servicio Django activo"
else
    show_error "❌ Servicio Django no está activo"
fi

# Verificar Nginx
if systemctl is-active --quiet nginx; then
    show_success "✅ Nginx activo"
else
    show_error "❌ Nginx no está activo"
fi

# Verificar conectividad
sleep 5

if curl -s http://localhost:8001/api/estudiantes/ > /dev/null; then
    show_success "✅ API Django respondiendo"
else
    show_warning "⚠️ API Django no responde (puede necesitar tiempo para iniciar)"
fi

echo ""
echo "================================================================"
show_success "🎉 Despliegue completado exitosamente"
echo ""
echo "📱 URLs de acceso:"
echo "   Aplicación: https://conformacion.twentybyte.com"
echo "   API: https://conformacion.twentybyte.com/api"
echo "   Admin: https://conformacion.twentybyte.com/admin"
echo ""
echo "🔧 Comandos de gestión:"
echo "   Iniciar: sudo systemctl start conformacion"
echo "   Detener: sudo systemctl stop conformacion"
echo "   Reiniciar: sudo systemctl restart conformacion"
echo "   Estado: sudo systemctl status conformacion"
echo "   Logs: sudo journalctl -u conformacion -f"
echo ""
echo "📊 Recursos utilizados:"
echo "   Puerto 4201: Angular (desarrollo)"
echo "   Puerto 8001: Django (producción)"
echo "   Puerto 3306: MySQL (existente)"
echo "   Espacio: ~85 MB"
echo "================================================================"
