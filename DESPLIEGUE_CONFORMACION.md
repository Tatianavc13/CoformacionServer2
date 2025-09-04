# 🚀 Despliegue Sistema Coformación - conformacion.twentybyte.com

## 📋 Configuración Específica del Servidor

### 🔧 Puertos Utilizados
- **Angular**: 4201 (desarrollo) → 80/443 (producción via Nginx)
- **Django**: 8001 (producción)
- **MySQL**: 3306 (existente)
- **Nginx**: 80/443 (proxy reverso)

### 🌐 Dominio
- **Producción**: `conformacion.twentybyte.com`
- **SSL**: Configurado para usar certificados existentes

## 📦 Archivos de Configuración Creados

### 1. Configuración Django
- `backendCoformacion/backend_uniempresarial/settings_prod.py`
- Configurado para MySQL existente en puerto 3306
- Base de datos: `coformacion1`
- Usuario: `coformacion_user`
- Contraseña: `Coformacion2024#Secure`

### 2. Configuración Frontend
- `src/environments/environment.prod.ts`
- URL de API: `https://conformacion.twentybyte.com/api`

### 3. Scripts de Despliegue
- `start-conformacion.sh` - Iniciar servicios
- `stop-conformacion.sh` - Detener servicios
- `deploy-conformacion.sh` - Despliegue completo
- `setup-database.sql` - Configuración de base de datos

### 4. Configuración Nginx
- `nginx-conformacion.conf` - Configuración específica del proyecto

## 🚀 Pasos de Despliegue

### Paso 1: Preparar el Servidor
```bash
# Subir archivos al servidor
scp -r . usuario@servidor:/var/www/conformacion/

# Conectar al servidor
ssh usuario@servidor
cd /var/www/conformacion
```

### Paso 2: Configurar Base de Datos
```bash
# Ejecutar script de configuración
mysql -u root -p < setup-database.sql
```

### Paso 3: Desplegar Aplicación
```bash
# Hacer ejecutable el script
chmod +x deploy-conformacion.sh

# Ejecutar despliegue completo
./deploy-conformacion.sh
```

### Paso 4: Configurar Nginx (Manual)
```bash
# Copiar configuración de Nginx
sudo cp nginx-conformacion.conf /etc/nginx/sites-available/conformacion

# Habilitar sitio
sudo ln -s /etc/nginx/sites-available/conformacion /etc/nginx/sites-enabled/

# Verificar configuración
sudo nginx -t

# Recargar Nginx
sudo systemctl reload nginx
```

## 🔧 Comandos de Gestión

### Servicios del Sistema
```bash
# Django
sudo systemctl start conformacion
sudo systemctl stop conformacion
sudo systemctl restart conformacion
sudo systemctl status conformacion

# Nginx
sudo systemctl start nginx
sudo systemctl stop nginx
sudo systemctl restart nginx
sudo systemctl status nginx
```

### Logs
```bash
# Logs de Django
sudo journalctl -u conformacion -f

# Logs de Nginx
sudo tail -f /var/log/nginx/conformacion_access.log
sudo tail -f /var/log/nginx/conformacion_error.log

# Logs del sistema
sudo tail -f /var/log/coformacion.log
```

### Verificación de Servicios
```bash
# Verificar puertos
sudo netstat -tlnp | grep :8001
sudo netstat -tlnp | grep :4201

# Verificar conectividad
curl http://localhost:8001/api/estudiantes/
curl https://conformacion.twentybyte.com/api/estudiantes/
```

## 📊 Recursos del Sistema

### Espacio en Disco
- **Proyecto**: ~75 MB
- **Base de datos**: ~10 MB
- **Total**: ~85 MB

### Memoria RAM
- **Angular**: ~100-200 MB
- **Django**: ~150-300 MB
- **Total**: ~250-500 MB

### Puertos
- **4201**: Angular (desarrollo)
- **8001**: Django (producción)
- **3306**: MySQL (existente)
- **80/443**: Nginx (proxy reverso)

## 🔒 Seguridad

### Configuración SSL
- Usa certificados existentes de `twentybyte.com`
- Configuración SSL moderna (TLS 1.2/1.3)
- Headers de seguridad habilitados

### Base de Datos
- Usuario específico para el proyecto
- Privilegios limitados a la base de datos `coformacion1`
- Conexión local únicamente

### CORS
- Configurado para `conformacion.twentybyte.com`
- Credenciales habilitadas
- Métodos permitidos: GET, POST, PUT, DELETE, OPTIONS

## 🎯 URLs de Acceso

- **Aplicación**: https://conformacion.twentybyte.com
- **API**: https://conformacion.twentybyte.com/api
- **Admin Django**: https://conformacion.twentybyte.com/admin
- **Health Check**: https://conformacion.twentybyte.com/health

## 🔧 Credenciales del Sistema

### Base de Datos
- **Usuario**: `coformacion_user`
- **Contraseña**: `Coformacion2024#Secure`
- **Base de datos**: `coformacion1`

### Login Web
- **Usuario Admin**: `Usuario Admin`
- **Identificación**: `9999999999`

## 📈 Monitoreo

### Verificación de Estado
```bash
# Estado de servicios
sudo systemctl status conformacion nginx

# Uso de recursos
htop
df -h

# Conectividad
curl -I https://conformacion.twentybyte.com
```

### Logs Importantes
- **Django**: `/var/log/coformacion.log`
- **Nginx**: `/var/log/nginx/conformacion_*.log`
- **Sistema**: `sudo journalctl -u conformacion`

## 🚨 Solución de Problemas

### Problema: Django no inicia
```bash
# Verificar logs
sudo journalctl -u conformacion -f

# Verificar configuración
cd /var/www/conformacion/backendCoformacion
source venv/bin/activate
python manage.py check --settings=backend_uniempresarial.settings_prod
```

### Problema: Nginx no sirve la aplicación
```bash
# Verificar configuración
sudo nginx -t

# Verificar logs
sudo tail -f /var/log/nginx/conformacion_error.log

# Verificar conectividad
curl http://localhost:8001/api/estudiantes/
```

### Problema: Base de datos no conecta
```bash
# Verificar MySQL
sudo systemctl status mysql

# Probar conexión
mysql -u coformacion_user -p coformacion1

# Verificar configuración Django
cd /var/www/conformacion/backendCoformacion
source venv/bin/activate
python manage.py dbshell --settings=backend_uniempresarial.settings_prod
```

## ✅ Checklist de Despliegue

- [ ] Archivos subidos al servidor
- [ ] Base de datos configurada
- [ ] Dependencias instaladas
- [ ] Migraciones ejecutadas
- [ ] Archivos estáticos recopilados
- [ ] Nginx configurado
- [ ] Servicio Django creado
- [ ] SSL configurado
- [ ] Aplicación accesible
- [ ] API funcionando
- [ ] Logs configurados

## 📞 Soporte

En caso de problemas:
1. Verificar logs del sistema
2. Comprobar estado de servicios
3. Verificar conectividad de red
4. Revisar configuración de Nginx
5. Verificar permisos de archivos
