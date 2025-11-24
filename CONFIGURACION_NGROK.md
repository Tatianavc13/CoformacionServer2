# 🌐 Configuración para ngrok - Acceso Público

Este documento explica cómo configurar el proyecto para que sea accesible públicamente a través de ngrok.

## ✅ Configuración Realizada

### Frontend (Angular)
- ✅ `angular.json` configurado con `host: "0.0.0.0"` y `allowedHosts: ["all"]`
- ✅ Puerto: 4201

**Configuración en `angular.json`:**
```json
"serve": {
  "builder": "@angular-devkit/build-angular:dev-server",
  "options": {
    "host": "0.0.0.0",           // Escucha en todas las interfaces
    "port": 4201,                 // Puerto del frontend
    "disableHostCheck": true,    // Desactiva verificación de host
    "allowedHosts": [
      ".ngrok-free.dev",          // Permite cualquier subdominio de ngrok
      ".ngrok-free.app",          // Dominios alternativos de ngrok
      ".ngrok.io",                 // Dominios legacy de ngrok
      "localhost",
      "127.0.0.1"
    ]
  }
}
```

**Nota**: El punto (`.`) al inicio permite cualquier subdominio. Por ejemplo:
- ✅ `xxxx-xxxx-xxxx.ngrok-free.dev` - Permitido
- ✅ `cualquier-cosa.ngrok-free.dev` - Permitido
- ✅ `localhost` - Permitido
- ❌ `otro-dominio.com` - No permitido (solo ngrok y localhost)

### Backend (Django)
- ✅ `ALLOWED_HOSTS` configurado para permitir cualquier host (`'*'`)
- ✅ `CORS_ALLOW_ALL_ORIGINS = True` para desarrollo
- ✅ `CSRF_TRUSTED_ORIGINS` configurado para localhost
- ✅ Puerto: 8000 (debe iniciarse con `0.0.0.0:8000`)

## 🚀 Pasos para Usar ngrok

### Opción 1: Script Automático (Recomendado)

**Windows:**
```powershell
.\start_with_ngrok.bat
```

**Linux/Mac:**
```bash
chmod +x start_with_ngrok.sh
./start_with_ngrok.sh
```

Este script iniciará automáticamente:
- Backend Django en `0.0.0.0:8000`
- Frontend Angular en `0.0.0.0:4201`
- ngrok para el frontend

### Opción 2: Manual

#### 1. Iniciar el Backend Django

```powershell
cd backendCoformacion
.\venv\Scripts\Activate.ps1
python manage.py runserver 0.0.0.0:8000
```

**Importante**: Usa `0.0.0.0` en lugar de `127.0.0.1` para que sea accesible desde fuera.

#### 2. Iniciar el Frontend Angular

En otra terminal:

```powershell
ng serve --host 0.0.0.0 --port 4201
```

O simplemente:
```powershell
ng serve
```
(La configuración en `angular.json` ya tiene `host: "0.0.0.0"`)

#### 3. Iniciar ngrok para el Frontend

En otra terminal:

```powershell
ngrok http 4201
```

#### 4. Iniciar ngrok para el Backend (Opcional)

Si también quieres exponer el backend públicamente:

```powershell
ngrok http 8000
```

#### 5. Obtener las URLs Públicas

ngrok mostrará algo como:

```
Forwarding  https://xxxx-xxxx-xxxx.ngrok-free.app -> http://localhost:4201
```

Esta es la URL pública del frontend que puedes compartir.

**Si también expusiste el backend**, tendrás otra URL para el backend.

## 🔧 Configuración Adicional

### Configuración del Backend

El backend ya está configurado para aceptar conexiones desde cualquier origen:

- ✅ `ALLOWED_HOSTS = ['*']` - Permite cualquier host
- ✅ `CORS_ALLOW_ALL_ORIGINS = True` - Permite CORS desde cualquier origen
- ✅ `CSRF_TRUSTED_ORIGINS` - Configurado para localhost

**⚠️ IMPORTANTE**: Esta configuración es solo para desarrollo. En producción:
- Especifica los hosts permitidos en `ALLOWED_HOSTS`
- Lista los orígenes permitidos en `CORS_ALLOWED_ORIGINS`
- Desactiva `CORS_ALLOW_ALL_ORIGINS`

## 📝 Actualizar Environment para ngrok

### Opción 1: Frontend y Backend en el mismo dominio ngrok

Si usas un proxy de ngrok que enruta tanto frontend como backend:

```typescript
// src/environments/environment.ts
export const environment = {
  production: false,
  apiUrl: 'https://tu-ngrok.ngrok-free.app/api'
};
```

### Opción 2: Frontend y Backend en dominios ngrok separados

Si tienes dos instancias de ngrok (una para frontend, otra para backend):

```typescript
// src/environments/environment.ts
export const environment = {
  production: false,
  apiUrl: 'https://tu-backend-ngrok.ngrok-free.app/api'
};
```

**Nota**: Con `CORS_ALLOW_ALL_ORIGINS = True`, el backend aceptará peticiones desde cualquier origen, así que no necesitas configurar nada adicional.

## 🔒 Seguridad

### Recomendaciones:

1. **No uses ngrok en producción** - Solo para desarrollo/testing
2. **Usa autenticación** - Asegúrate de que tu API requiera autenticación
3. **Limita el tiempo** - ngrok gratuito tiene límites de tiempo
4. **No compartas URLs públicamente** - Las URLs de ngrok son temporales

### Versión Paga de ngrok:

Si necesitas un dominio fijo y más características:
- Dominio personalizado fijo
- Sin límites de tiempo
- Mejor rendimiento
- Más opciones de seguridad

## 🧪 Probar la Configuración

1. **Inicia el servidor Angular:**
   ```powershell
   ng serve
   ```

2. **Inicia ngrok:**
   ```powershell
   ngrok http 4201
   ```

3. **Abre la URL de ngrok en tu navegador** o compártela con otros

4. **Verifica que funcione:**
   - La aplicación debería cargar normalmente
   - Las peticiones al API deberían funcionar (si también expusiste el backend)

## 🐛 Solución de Problemas

### Error: "Invalid Host header"

Si ves este error, significa que `disableHostCheck` no está funcionando. Solución:

```powershell
ng serve --host 0.0.0.0 --port 4201 --disable-host-check
```

O verifica que `angular.json` tenga la configuración correcta.

### Error de CORS

Si ves errores de CORS al acceder a través de ngrok:

1. Agrega el dominio ngrok a `CORS_ALLOWED_ORIGINS` en Django
2. O temporalmente usa `CORS_ALLOW_ALL_ORIGINS = True` (solo desarrollo)

### La URL de ngrok cambia cada vez

En la versión gratuita, ngrok genera una nueva URL cada vez. Soluciones:

1. **Usa un dominio personalizado** (requiere cuenta paga)
2. **Actualiza la configuración** cada vez que cambies la URL
3. **Usa ngrok con autenticación** para URLs más estables

## 📚 Recursos

- [Documentación de ngrok](https://ngrok.com/docs)
- [Angular Dev Server Options](https://angular.io/cli/serve)
- [Django CORS Headers](https://pypi.org/project/django-cors-headers/)

## ✅ Checklist

- [ ] `angular.json` configurado con `host: "0.0.0.0"` y `allowedHosts: ["all"]`
- [ ] Servidor Angular iniciado en puerto 4201
- [ ] ngrok instalado y corriendo
- [ ] URL de ngrok obtenida
- [ ] CORS configurado en Django (si expones el backend)
- [ ] Environment actualizado (si es necesario)
- [ ] Probado acceso desde la URL de ngrok

