# 🚀 Guía de Despliegue - Sistema Coformación en Linux

## 📋 Requisitos del Servidor

### Hardware Mínimo
- **CPU**: 2 cores
- **RAM**: 4 GB
- **Disco**: 20 GB SSD
- **Red**: Conexión estable a internet

### Software Requerido
- **OS**: Ubuntu 20.04+ / CentOS 8+ / Debian 11+
- **Python**: 3.8+
- **Node.js**: 18+
- **MySQL**: 8.0+
- **Nginx**: 1.18+
- **Git**: Última versión

## 🔧 Instalación Paso a Paso

### 1. Preparar el Servidor

```bash
# Actualizar sistema
sudo apt update && sudo apt upgrade -y

# Instalar dependencias básicas
sudo apt install -y curl wget git unzip software-properties-common
```

### 2. Instalar Python 3.8+

```bash
# Ubuntu/Debian
sudo apt install -y python3 python3-pip python3-venv python3-dev

# Verificar versión
python3 --version
```

### 3. Instalar Node.js 18+

```bash
# Instalar Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

# Verificar instalación
node --version
npm --version
```

### 4. Instalar MySQL 8.0

```bash
# Instalar MySQL
sudo apt install -y mysql-server mysql-client

# Configurar MySQL
sudo mysql_secure_installation

# Crear base de datos
sudo mysql -u root -p
```

```sql
CREATE DATABASE coformacion1 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'coformacion_user'@'localhost' IDENTIFIED BY 'coformacion2024';
GRANT ALL PRIVILEGES ON coformacion1.* TO 'coformacion_user'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

### 5. Instalar Nginx

```bash
# Instalar Nginx
sudo apt install -y nginx

# Habilitar y iniciar Nginx
sudo systemctl enable nginx
sudo systemctl start nginx
```

### 6. Desplegar la Aplicación

```bash
# Crear directorio de la aplicación
sudo mkdir -p /var/www/coformacion
sudo chown -R $USER:$USER /var/www/coformacion
cd /var/www/coformacion

# Clonar o subir el proyecto
git clone <tu-repositorio> .
# O subir los archivos via SCP/SFTP

# Instalar dependencias del backend
cd backendCoformacion
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Instalar dependencias del frontend
cd ..
npm install
ng build
```

### 7. Configurar Django para Producción

```bash
# Crear archivo de configuración de producción
sudo nano /var/www/coformacion/backendCoformacion/backend_uniempresarial/settings_prod.py
```

```python
import os
from .settings import *

DEBUG = False
ALLOWED_HOSTS = ['tu-dominio.com', 'tu-ip-servidor']

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'coformacion1',
        'USER': 'coformacion_user',
        'PASSWORD': 'coformacion2024',
        'HOST': 'localhost',
        'PORT': '3306',
    }
}

STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')

MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, 'media')
```

### 8. Configurar Nginx

```bash
# Crear configuración de Nginx
sudo nano /etc/nginx/sites-available/coformacion
```

```nginx
server {
    listen 80;
    server_name tu-dominio.com www.tu-dominio.com;

    # Frontend Angular
    location / {
        root /var/www/coformacion/dist/front-cofor;
        try_files $uri $uri/ /index.html;
    }

    # Backend API
    location /api/ {
        proxy_pass http://127.0.0.1:8001;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    # Archivos estáticos
    location /static/ {
        alias /var/www/coformacion/backendCoformacion/staticfiles/;
    }

    # Archivos de media
    location /media/ {
        alias /var/www/coformacion/backendCoformacion/media/;
    }
}
```

```bash
# Habilitar sitio
sudo ln -s /etc/nginx/sites-available/coformacion /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

### 9. Configurar Gunicorn

```bash
# Instalar Gunicorn
cd /var/www/coformacion/backendCoformacion
source venv/bin/activate
pip install gunicorn

# Crear archivo de configuración
nano gunicorn.conf.py
```

```python
bind = "127.0.0.1:8001"
workers = 3
worker_class = "sync"
worker_connections = 1000
timeout = 30
keepalive = 2
max_requests = 1000
max_requests_jitter = 100
preload_app = True
```

### 10. Crear Servicios del Sistema

```bash
# Crear servicio para Django
sudo nano /etc/systemd/system/coformacion.service
```

```ini
[Unit]
Description=Coformacion Django App
After=network.target

[Service]
User=www-data
Group=www-data
WorkingDirectory=/var/www/coformacion/backendCoformacion
Environment="PATH=/var/www/coformacion/backendCoformacion/venv/bin"
ExecStart=/var/www/coformacion/backendCoformacion/venv/bin/gunicorn --config gunicorn.conf.py backend_uniempresarial.wsgi:application
Restart=always

[Install]
WantedBy=multi-user.target
```

```bash
# Habilitar y iniciar servicio
sudo systemctl daemon-reload
sudo systemctl enable coformacion
sudo systemctl start coformacion
```

### 11. Configurar SSL (Opcional)

```bash
# Instalar Certbot
sudo apt install -y certbot python3-certbot-nginx

# Obtener certificado SSL
sudo certbot --nginx -d tu-dominio.com -d www.tu-dominio.com
```

## 🔧 Comandos de Mantenimiento

### Iniciar/Detener Servicios
```bash
# Django
sudo systemctl start coformacion
sudo systemctl stop coformacion
sudo systemctl restart coformacion

# Nginx
sudo systemctl start nginx
sudo systemctl stop nginx
sudo systemctl restart nginx

# MySQL
sudo systemctl start mysql
sudo systemctl stop mysql
sudo systemctl restart mysql
```

### Verificar Estado
```bash
# Ver logs
sudo journalctl -u coformacion -f
sudo tail -f /var/log/nginx/error.log

# Verificar puertos
sudo netstat -tlnp | grep :80
sudo netstat -tlnp | grep :8001
sudo netstat -tlnp | grep :3306
```

### Actualizar Aplicación
```bash
cd /var/www/coformacion
git pull origin main

# Backend
cd backendCoformacion
source venv/bin/activate
pip install -r requirements.txt
python manage.py migrate
python manage.py collectstatic --noinput
sudo systemctl restart coformacion

# Frontend
ng build
sudo systemctl reload nginx
```

## 📊 Monitoreo y Logs

### Logs Importantes
- **Django**: `/var/log/coformacion.log`
- **Nginx**: `/var/log/nginx/access.log`, `/var/log/nginx/error.log`
- **MySQL**: `/var/log/mysql/error.log`
- **Sistema**: `sudo journalctl -u coformacion`

### Monitoreo de Recursos
```bash
# Uso de CPU y memoria
htop

# Espacio en disco
df -h

# Procesos de la aplicación
ps aux | grep gunicorn
ps aux | grep nginx
```

## 🔒 Seguridad

### Firewall
```bash
# Configurar UFW
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable
```

### Backup de Base de Datos
```bash
# Crear backup
mysqldump -u coformacion_user -p coformacion1 > backup_$(date +%Y%m%d_%H%M%S).sql

# Restaurar backup
mysql -u coformacion_user -p coformacion1 < backup_file.sql
```

## 📈 Escalabilidad

### Para Mayor Carga
- Aumentar workers de Gunicorn
- Usar Redis para cache
- Implementar load balancer
- Usar CDN para archivos estáticos

### Variables de Entorno
```bash
# Crear archivo .env
nano /var/www/coformacion/backendCoformacion/.env
```

```env
DEBUG=False
SECRET_KEY=tu-secret-key-super-seguro
DATABASE_URL=mysql://coformacion_user:coformacion2024@localhost:3306/coformacion1
ALLOWED_HOSTS=tu-dominio.com,www.tu-dominio.com
```

## 🎯 URLs de Acceso

- **Aplicación**: http://tu-dominio.com
- **API**: http://tu-dominio.com/api/
- **Admin Django**: http://tu-dominio.com/admin/

## 📞 Soporte

En caso de problemas:
1. Verificar logs del sistema
2. Comprobar estado de servicios
3. Verificar conectividad de red
4. Revisar configuración de firewall
