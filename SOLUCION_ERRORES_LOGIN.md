# 🔧 Solución de Errores de Login

## ❌ Error: "Credenciales inválidas o error del servidor"

Este error puede tener varias causas. Sigue estos pasos para diagnosticar y solucionar:

### 1. Verificar que el Backend esté Corriendo

**Síntoma**: Error de conexión o timeout

**Solución**:
```bash
# En PowerShell, dentro del directorio backendCoformacion
.\venv\Scripts\Activate.ps1
python manage.py runserver 127.0.0.1:8000
```

**Verificar**: Abre en el navegador `http://127.0.0.1:8000/api/` - debería mostrar la API de Django REST Framework

### 2. Verificar que el Frontend esté Corriendo

**Síntoma**: No se puede acceder a la aplicación

**Solución**:
```bash
# En la raíz del proyecto
ng serve --port 4201
```

**Verificar**: Abre en el navegador `http://localhost:4201`

### 3. Verificar la URL del API

**Problema**: El frontend no puede conectarse al backend

**Solución**: Verifica que `src/environments/environment.ts` tenga:
```typescript
export const environment = {
  production: false,
  apiUrl: 'http://127.0.0.1:8000/api'
};
```

**Nota**: Si el backend corre en otro puerto (ej: 8001), cambia la URL aquí.

### 4. Verificar Credenciales en la Base de Datos

**Problema**: Las credenciales no existen o están incorrectas

**Solución**: Ejecuta estas consultas SQL:

```sql
-- Conectar a MySQL
mysql -u root -h 127.0.0.1 -P 3307 coformacion1

-- Ver estudiantes disponibles
SELECT nombre_completo, numero_documento 
FROM estudiantes 
WHERE estado = 'Activo' 
LIMIT 5;

-- Ver empresas disponibles
SELECT nombre_comercial, razon_social, nit 
FROM empresas 
WHERE estado = 1 
LIMIT 5;
```

**Ver documento completo**: `VERIFICAR_CREDENCIALES_BD.md`

### 5. Error: "ModuleNotFoundError: No module named 'dj_database_url'"

**Problema**: El servidor Django está intentando importar un módulo que no está instalado

**Solución**:
1. **Detén el servidor Django** (Ctrl+C)
2. El archivo `settings.py` ya está corregido para manejar este error
3. **Reinicia el servidor**:
```bash
.\venv\Scripts\Activate.ps1
python manage.py runserver 127.0.0.1:8000
```

**Nota**: Este error no debería aparecer porque el código ya maneja la ausencia del módulo.

### 6. Error: "Couldn't import Django"

**Problema**: El entorno virtual no está activado

**Solución**:
```bash
cd backendCoformacion
.\venv\Scripts\Activate.ps1
python manage.py runserver
```

### 7. Error: "No se pudo conectar al servidor"

**Problema**: El backend no está corriendo o hay un problema de CORS

**Solución**:
1. Verifica que el backend esté corriendo en `http://127.0.0.1:8000`
2. Verifica CORS en `settings.py` - debería incluir `http://localhost:4201`
3. Abre la consola del navegador (F12) y revisa los errores de red

### 8. Error: "Credenciales incorrectas" (401)

**Problema**: Los datos ingresados no coinciden con la base de datos

**Solución**:
1. Verifica que estés usando el **nombre completo exacto** (o parte de él)
2. Verifica que el **número de documento/NIT** sea exacto
3. Para estudiantes: usa `nombre_completo` y `numero_documento`
4. Para empresas: usa `nombre_comercial` o `razon_social` y `nit`

**Ejemplo de búsqueda en BD**:
```sql
-- Buscar estudiante específico
SELECT * FROM estudiantes 
WHERE nombre_completo LIKE '%María%' 
  AND numero_documento = '1234567891';

-- Buscar empresa específica
SELECT * FROM empresas 
WHERE (nombre_comercial LIKE '%Soluciones%' OR razon_social LIKE '%Soluciones%')
  AND nit = '9001234567';
```

### 9. Error: "Error interno del servidor" (500)

**Problema**: Hay un error en el código del backend

**Solución**:
1. Revisa la consola del servidor Django para ver el error completo
2. Verifica que las migraciones estén aplicadas:
```bash
python manage.py migrate
```
3. Verifica que la base de datos esté accesible:
```bash
python manage.py dbshell
```

### 10. Error: CORS bloqueado

**Problema**: El navegador bloquea la petición por CORS

**Solución**: Verifica en `settings.py`:
```python
CORS_ALLOWED_ORIGINS = [
    "http://localhost:4200",
    "http://127.0.0.1:4200",
    "http://localhost:4201",
    "http://127.0.0.1:4201",
]
```

## 🔍 Diagnóstico Paso a Paso

### Paso 1: Verificar Backend
```bash
# Terminal 1: Backend
cd backendCoformacion
.\venv\Scripts\Activate.ps1
python manage.py runserver 127.0.0.1:8000
```

**Esperado**: Deberías ver:
```
Starting development server at http://127.0.0.1:8000/
```

### Paso 2: Verificar Frontend
```bash
# Terminal 2: Frontend
ng serve --port 4201
```

**Esperado**: Deberías ver:
```
✔ Compiled successfully.
** Angular Live Development Server is listening on localhost:4201 **
```

### Paso 3: Probar API Directamente
Abre en el navegador: `http://127.0.0.1:8000/api/auth/login/`

**Esperado**: Deberías ver un formulario de Django REST Framework o un error 405 (Method Not Allowed), lo cual es normal para GET.

### Paso 4: Probar Login con Credenciales Conocidas

**Desde la consola del navegador (F12)**:
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
.then(r => r.json())
.then(console.log)
.catch(console.error);
```

**Esperado**: Deberías ver una respuesta JSON con `success: true` o un error específico.

### Paso 5: Verificar Base de Datos
```sql
mysql -u root -h 127.0.0.1 -P 3307 coformacion1

SELECT COUNT(*) FROM estudiantes;
SELECT COUNT(*) FROM empresas;
```

**Esperado**: Deberías ver números mayores a 0.

## 📋 Checklist de Verificación

- [ ] Backend corriendo en `http://127.0.0.1:8000`
- [ ] Frontend corriendo en `http://localhost:4201`
- [ ] Entorno virtual activado para el backend
- [ ] Migraciones aplicadas (`python manage.py migrate`)
- [ ] Base de datos accesible
- [ ] Hay datos en las tablas `estudiantes` o `empresas`
- [ ] CORS configurado correctamente
- [ ] URL del API correcta en `environment.ts`
- [ ] Consola del navegador sin errores de red
- [ ] Consola del servidor Django sin errores

## 🆘 Si Nada Funciona

1. **Reinicia todo**:
   - Detén backend y frontend
   - Reinicia ambos
   
2. **Limpia caché**:
   ```bash
   # Frontend
   rm -rf node_modules/.cache
   ng serve --port 4201
   
   # Backend (si es necesario)
   python manage.py flush  # CUIDADO: Esto borra datos
   ```

3. **Verifica logs**:
   - Consola del navegador (F12 → Console)
   - Terminal del backend
   - Terminal del frontend

4. **Prueba con curl/Postman**:
   ```bash
   curl -X POST http://127.0.0.1:8000/api/auth/login/ \
     -H "Content-Type: application/json" \
     -d '{"nombre_completo": "María González", "numero_documento": "1234567891"}'
   ```

## 📞 Información para Reportar el Error

Si el problema persiste, proporciona:

1. **Mensaje de error exacto** (de la pantalla y consola)
2. **Código de estado HTTP** (200, 400, 401, 500, etc.)
3. **Respuesta del servidor** (de la consola del navegador, pestaña Network)
4. **Logs del backend** (terminal donde corre Django)
5. **Credenciales que estás intentando usar**
6. **Resultado de las consultas SQL** de verificación


