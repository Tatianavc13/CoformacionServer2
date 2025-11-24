# 🔧 Solución: Error {"isTrusted":true}

Este error indica que hay un problema de **conexión o CORS** entre el frontend y el backend.

## 🔍 Diagnóstico Rápido

El error `{"isTrusted":true}` ocurre cuando:
1. El servidor Django **no está corriendo**
2. Hay un problema de **CORS** (Cross-Origin Resource Sharing)
3. El **firewall** está bloqueando la conexión
4. La **URL del API** es incorrecta

## ✅ Solución Paso a Paso

### Paso 1: Verificar que el Backend esté Corriendo

**Abre una terminal PowerShell y ejecuta:**

```powershell
cd backendCoformacion
.\venv\Scripts\Activate.ps1
python manage.py runserver 127.0.0.1:8000
```

**Esperado**: Deberías ver:
```
Starting development server at http://127.0.0.1:8000/
Quit the server with CTRL-BREAK.
```

**⚠️ IMPORTANTE**: Si ves un error sobre `dj_database_url`, el servidor está usando una versión en caché. **Detén el servidor (Ctrl+C) y reinícialo**.

### Paso 2: Verificar que el Frontend esté Corriendo

**Abre otra terminal PowerShell y ejecuta:**

```powershell
ng serve --port 4201
```

**Esperado**: Deberías ver:
```
✔ Compiled successfully.
** Angular Live Development Server is listening on localhost:4201 **
```

### Paso 3: Probar la Conexión Directamente

**Abre tu navegador en:** `http://127.0.0.1:8000/api/`

**Esperado**: Deberías ver la interfaz de Django REST Framework o un error 404 (lo cual es normal).

**Si no carga**: El backend no está corriendo correctamente.

### Paso 4: Verificar CORS en el Backend

**Abre el archivo:** `backendCoformacion/backend_uniempresarial/settings.py`

**Verifica que tenga:**

```python
CORS_ALLOWED_ORIGINS = [
    "http://localhost:4200",
    "http://127.0.0.1:4200",
    "http://localhost:4201",
    "http://127.0.0.1:4201",
]

CORS_ALLOW_CREDENTIALS = True
```

**Si falta, agrégalo y reinicia el servidor Django.**

### Paso 5: Probar el Login desde la Consola del Navegador

**Abre la consola del navegador (F12) y ejecuta:**

```javascript
fetch('http://127.0.0.1:8000/api/auth/login/', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
  },
  body: JSON.stringify({
    nombre_completo: 'María González',
    numero_documento: '1234567891'
  })
})
.then(r => {
  console.log('Status:', r.status);
  return r.json();
})
.then(data => console.log('Response:', data))
.catch(error => {
  console.error('Error:', error);
  console.error('Error details:', error.message);
});
```

**Si ves un error de CORS**, el problema está en la configuración del backend.

## 🚨 Soluciones Específicas

### Solución 1: El Backend No Está Corriendo

**Síntoma**: Error de conexión, timeout, o `{"isTrusted":true}`

**Solución**:
```powershell
# Terminal 1: Backend
cd backendCoformacion
.\venv\Scripts\Activate.ps1
python manage.py runserver 127.0.0.1:8000
```

**Verifica**: Abre `http://127.0.0.1:8000/api/` en el navegador.

### Solución 2: Error de CORS

**Síntoma**: Error en la consola del navegador sobre CORS

**Solución**: Asegúrate de que `settings.py` tenga:

```python
INSTALLED_APPS = [
    # ... otras apps
    'corsheaders',
]

MIDDLEWARE = [
    'corsheaders.middleware.CorsMiddleware',  # Debe estar al principio
    # ... otros middlewares
]

CORS_ALLOWED_ORIGINS = [
    "http://localhost:4200",
    "http://127.0.0.1:4200",
    "http://localhost:4201",
    "http://127.0.0.1:4201",
]

CORS_ALLOW_CREDENTIALS = True
```

**Luego reinicia el servidor Django.**

### Solución 3: URL del API Incorrecta

**Síntoma**: Error 404 o conexión fallida

**Solución**: Verifica `src/environments/environment.ts`:

```typescript
export const environment = {
  production: false,
  apiUrl: 'http://127.0.0.1:8000/api'
};
```

**Nota**: Si el backend corre en otro puerto (ej: 8001), cambia la URL aquí.

### Solución 4: Firewall Bloqueando la Conexión

**Síntoma**: Timeout o conexión rechazada

**Solución**:
1. Verifica que el firewall de Windows no esté bloqueando Python
2. Asegúrate de que el puerto 8000 esté disponible
3. Prueba desactivar temporalmente el firewall para probar

### Solución 5: Error en settings.py (dj_database_url)

**Síntoma**: El servidor Django no inicia o muestra error de importación

**Solución**: El archivo `settings.py` ya está corregido. Si aún ves el error:

1. **Detén el servidor** (Ctrl+C)
2. **Verifica** que el archivo tenga el código correcto (líneas 18-25):
```python
# Try to import dj_database_url if available (for production deployments)
dj_database_url = None
try:
    dj_database_url_spec = importlib.util.find_spec("dj_database_url")
    if dj_database_url_spec is not None:
        dj_database_url = importlib.import_module("dj_database_url")
except ImportError:
    pass
```
3. **Reinicia el servidor**

## 🔍 Verificación Final

### Checklist:

- [ ] Backend corriendo en `http://127.0.0.1:8000`
- [ ] Frontend corriendo en `http://localhost:4201`
- [ ] Puedes acceder a `http://127.0.0.1:8000/api/` en el navegador
- [ ] CORS configurado correctamente en `settings.py`
- [ ] URL del API correcta en `environment.ts`
- [ ] No hay errores en la consola del navegador (F12)
- [ ] No hay errores en la terminal del backend

### Prueba Final:

1. Abre `http://localhost:4201` en el navegador
2. Abre la consola del navegador (F12)
3. Intenta hacer login con credenciales válidas
4. Revisa los mensajes en la consola

**Si el error persiste**, comparte:
- El mensaje exacto de error en la consola del navegador
- El mensaje exacto de error en la terminal del backend
- Una captura de pantalla de la pestaña Network en el navegador (F12 → Network)

## 📞 Información Adicional

El error `{"isTrusted":true}` es un error de JavaScript que indica que la petición HTTP falló antes de llegar al servidor. Esto puede ser por:

1. **CORS**: El navegador bloquea la petición por políticas de seguridad
2. **Conexión**: El servidor no está disponible o no responde
3. **Firewall**: Un firewall está bloqueando la conexión
4. **URL incorrecta**: La URL del API no es correcta

Con los cambios realizados en el código, ahora deberías ver un mensaje de error más específico que te ayudará a identificar el problema exacto.


