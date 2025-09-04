# 🚀 Sistema de Coformación - ConformacionServer

## 📋 Descripción del Proyecto

Sistema web completo para la gestión de coformación entre empresas y estudiantes, desarrollado con tecnologías modernas y desplegado en `conformacion.twentybyte.com`.

## 🛠️ Stack Tecnológico

### Frontend
- **Framework**: Angular 17.1.0
- **Lenguaje**: TypeScript 5.3.2
- **Puerto**: 4201 (desarrollo) → 80/443 (producción)
- **Build**: Optimizado para producción

### Backend
- **Framework**: Django 5.2.3
- **API**: Django REST Framework 3.16.0
- **Lenguaje**: Python 3.8+
- **Puerto**: 8001 (producción)

### Base de Datos
- **Motor**: MySQL 8.0
- **Puerto**: 3306
- **Base de datos**: `coformacion1`
- **Usuario**: `coformacion_user`

### Servidor Web
- **Proxy Reverso**: Nginx
- **SSL**: Certificados existentes de twentybyte.com
- **Dominio**: conformacion.twentybyte.com

## 📁 Estructura del Proyecto

```
ConformacionServer/
├── src/                          # Frontend Angular
│   ├── app/                      # Componentes y servicios
│   ├── assets/                   # Recursos estáticos
│   └── environments/             # Configuraciones de entorno
├── backendCoformacion/           # Backend Django
│   ├── coformacion/              # App principal
│   ├── backend_uniempresarial/   # Configuración Django
│   └── manage.py                 # Script de gestión
├── dist/                         # Build de producción
├── scripts/                      # Scripts de despliegue
├── docs/                         # Documentación
└── config/                       # Archivos de configuración
```

## 🚀 Instalación y Despliegue

### Requisitos Previos
- Python 3.8+
- Node.js 18+
- MySQL 8.0
- Nginx
- Git

### Instalación Local

1. **Clonar el repositorio**
```bash
git clone https://github.com/AngelOso20/ConformacionServer.git
cd ConformacionServer
```

2. **Configurar Backend**
```bash
cd backendCoformacion
python -m venv venv
source venv/bin/activate  # Linux/Mac
# o
venv\Scripts\activate     # Windows
pip install -r requirements.txt
```

3. **Configurar Base de Datos**
```bash
mysql -u root -p < setup-database.sql
python manage.py migrate --settings=backend_uniempresarial.settings_prod
```

4. **Configurar Frontend**
```bash
npm install
ng build --configuration production
```

### Despliegue en Producción

1. **Ejecutar script de despliegue**
```bash
chmod +x deploy-conformacion.sh
./deploy-conformacion.sh
```

2. **Configurar Nginx**
```bash
sudo cp nginx-conformacion.conf /etc/nginx/sites-available/conformacion
sudo ln -s /etc/nginx/sites-available/conformacion /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

## 🔧 Scripts Disponibles

| Script | Descripción |
|--------|-------------|
| `start-conformacion.sh` | Iniciar servicios de desarrollo |
| `stop-conformacion.sh` | Detener servicios |
| `deploy-conformacion.sh` | Despliegue completo en producción |
| `setup-database.sql` | Configuración de base de datos |
| `setup-github.ps1` | Configuración de GitHub (Windows) |
| `setup-github.sh` | Configuración de GitHub (Linux/Mac) |

## 🌐 URLs de Acceso

- **Aplicación**: https://conformacion.twentybyte.com
- **API**: https://conformacion.twentybyte.com/api
- **Admin Django**: https://conformacion.twentybyte.com/admin
- **Health Check**: https://conformacion.twentybyte.com/health

## 🔐 Credenciales del Sistema

### Base de Datos
- **Usuario**: `coformacion_user`
- **Contraseña**: `Coformacion2024#Secure`
- **Base de datos**: `coformacion1`

### Login Web
- **Usuario Admin**: `Usuario Admin`
- **Identificación**: `9999999999`

## 📊 Características del Sistema

### Funcionalidades Principales
- ✅ Gestión de empresas
- ✅ Gestión de estudiantes
- ✅ Sistema de ofertas de coformación
- ✅ Recomendaciones automáticas
- ✅ Panel administrativo
- ✅ API REST completa
- ✅ Autenticación segura
- ✅ Interfaz responsive

### Datos de Prueba
- 10 empresas con información completa
- 4 estudiantes con datos realistas
- 8 ofertas de coformación variadas
- 5 contactos de empresa
- Sistema de recomendaciones funcionando

## 🔒 Seguridad

- Usuario de base de datos con acceso restringido
- Conexiones locales únicamente (localhost)
- SSL/TLS habilitado
- Headers de seguridad configurados
- CORS configurado para el dominio específico

## 📈 Recursos del Sistema

- **Espacio en disco**: ~85 MB
- **Memoria RAM**: ~250-500 MB
- **Puertos utilizados**: 4201, 8001, 3306
- **Dominio**: conformacion.twentybyte.com

## 🛠️ Comandos de Gestión

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
```

### Logs
```bash
# Logs de Django
sudo journalctl -u conformacion -f

# Logs de Nginx
sudo tail -f /var/log/nginx/conformacion_access.log
sudo tail -f /var/log/nginx/conformacion_error.log
```

## 📚 Documentación

- [Guía de Despliegue](DESPLIEGUE_CONFORMACION.md)
- [Configuración de Base de Datos](setup-database.sql)
- [Configuración de Nginx](nginx-conformacion.conf)

## 🤝 Contribución

Este es un proyecto privado. Para contribuir, contactar al administrador del repositorio.

## 📞 Soporte

En caso de problemas:
1. Verificar logs del sistema
2. Comprobar estado de servicios
3. Verificar conectividad de red
4. Revisar configuración de Nginx

## 📄 Licencia

Proyecto privado - Todos los derechos reservados.

---

**Desarrollado por**: AngelOso20  
**Repositorio**: https://github.com/AngelOso20/ConformacionServer  
**Dominio**: conformacion.twentybyte.com  
**Última actualización**: $(Get-Date -Format "yyyy-MM-dd")