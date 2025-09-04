# 🚀 Instrucciones para Ejecutar el Proyecto Coformación

## 📋 Requisitos Previos

- **Python 3.8+** instalado
- **Node.js 16+** y **npm** instalados
- **MySQL** ejecutándose en puerto 3306
- **Git** instalado

## 🔧 Configuración del Proyecto

### 1. Instalar Dependencias del Backend

```bash
cd backendCoformacion
pip install -r ../requirements.txt
```

### 2. Instalar Dependencias del Frontend

```bash
npm install
```

### 3. Configuración de la Base de Datos

El proyecto está configurado para usar:
- **Host**: localhost
- **Puerto**: 3306
- **Usuario**: root
- **Contraseña**: 12345
- **Base de datos**: coformacion1

**⚠️ IMPORTANTE**: Si tu proyecto CCB usa la misma base de datos, asegúrate de:
- Usar una base de datos diferente, o
- Ejecutar solo uno de los proyectos a la vez

## 🚀 Ejecución Automática

### Windows
```bash
start_coformacion.bat
```

### Linux/Mac
```bash
chmod +x start_coformacion.sh
./start_coformacion.sh
```

## 🔧 Ejecución Manual

### 1. Iniciar Backend (Puerto 8001)
```bash
cd backendCoformacion
python manage.py runserver 127.0.0.1:8001
```

### 2. Iniciar Frontend (Puerto 4201)
```bash
ng serve --port 4201
```

## 🌐 URLs del Proyecto

- **Frontend**: http://localhost:4201
- **Backend API**: http://localhost:8001/api
- **Admin Django**: http://localhost:8001/admin

## 📊 Estructura del Proyecto

```
coformacion-main/
├── backendCoformacion/          # Backend Django
│   ├── manage.py
│   ├── backend_uniempresarial/  # Configuración principal
│   └── coformacion/             # Aplicación principal
├── src/                         # Frontend Angular
│   ├── app/
│   ├── assets/
│   └── environments/
├── start_coformacion.bat        # Script Windows
├── start_coformacion.sh         # Script Linux/Mac
└── requirements.txt             # Dependencias Python
```

## 🔍 Verificación de Funcionamiento

### Backend
- Accede a http://localhost:8001/api/
- Deberías ver la respuesta de la API

### Frontend
- Accede a http://localhost:4201
- Deberías ver la aplicación Angular

### Base de Datos
- Verifica que MySQL esté ejecutándose
- La base de datos `coformacion1` debe existir

## 🚨 Solución de Problemas

### Error de Puerto en Uso
Si obtienes "Address already in use":
- Verifica que no haya otro servicio usando los puertos 8001 o 4201
- Usa `netstat -ano | findstr :8001` (Windows) o `lsof -i :8001` (Linux/Mac)

### Error de Conexión a MySQL
- Verifica que MySQL esté ejecutándose
- Verifica las credenciales en `backendCoformacion/backend_uniempresarial/settings.py`

### Error de Dependencias
- Ejecuta `pip install -r requirements.txt` nuevamente
- Ejecuta `npm install` nuevamente

## 📝 Notas Importantes

- **Puertos modificados**: 
  - Backend: 8000 → 8001
  - Frontend: 4200 → 4201
- **Base de datos**: Comparte puerto 3306 con tu proyecto CCB
- **CORS**: Configurado para permitir conexiones desde puerto 4201

## 🆘 Soporte

Si encuentras problemas:
1. Verifica que todos los servicios estén ejecutándose
2. Revisa los logs en las terminales
3. Verifica la conectividad de red
4. Asegúrate de que no haya conflictos de puertos
