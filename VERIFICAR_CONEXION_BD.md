# 🔍 Verificar Conexión a la Base de Datos

Este documento te muestra varias formas de verificar que tu proyecto Django esté conectado correctamente a la base de datos MySQL.

## 🚀 Método 1: Script de Prueba Automático (Recomendado)

He creado un script que verifica automáticamente la conexión y muestra información detallada.

### Ejecutar el script:

```powershell
cd backendCoformacion
.\venv\Scripts\Activate.ps1
python test_database_connection.py
```

**El script verificará:**
- ✅ Configuración de la base de datos
- ✅ Conexión exitosa
- ✅ Existencia de tablas importantes
- ✅ Cantidad de registros en cada tabla
- ✅ Consultas de ejemplo
- ✅ Versión de MySQL

## 🔧 Método 2: Django Shell

### Abrir Django Shell:

```powershell
cd backendCoformacion
.\venv\Scripts\Activate.ps1
python manage.py shell
```

### Comandos de prueba en el shell:

```python
# 1. Verificar conexión
from django.db import connection
cursor = connection.cursor()
cursor.execute("SELECT 1")
print("✅ Conexión exitosa!")

# 2. Ver tablas disponibles
cursor.execute("SHOW TABLES")
tables = cursor.fetchall()
for table in tables:
    print(table[0])

# 3. Contar estudiantes
from coformacion.models import Estudiantes
print(f"Total estudiantes: {Estudiantes.objects.count()}")

# 4. Ver un estudiante de ejemplo
estudiante = Estudiantes.objects.first()
if estudiante:
    print(f"Ejemplo: {estudiante.nombre_completo} - {estudiante.numero_documento}")

# 5. Contar empresas
from coformacion.models import Empresas
print(f"Total empresas: {Empresas.objects.count()}")

# 6. Ver una empresa de ejemplo
empresa = Empresas.objects.first()
if empresa:
    nombre = empresa.nombre_comercial or empresa.razon_social
    print(f"Ejemplo: {nombre} - {empresa.nit}")

# 7. Probar consulta de login (estudiante)
from coformacion.models import Estudiantes
estudiante = Estudiantes.objects.filter(
    nombre_completo__icontains="María",
    numero_documento="1234567891"
).first()
if estudiante:
    print(f"✅ Estudiante encontrado: {estudiante.nombre_completo}")
else:
    print("❌ Estudiante no encontrado")

# 8. Probar consulta de login (empresa)
from coformacion.models import Empresas
from django.db.models import Q
empresa = Empresas.objects.filter(
    Q(nombre_comercial__icontains="Soluciones") | Q(razon_social__icontains="Soluciones"),
    nit="9001234567"
).first()
if empresa:
    print(f"✅ Empresa encontrada: {empresa.nombre_comercial or empresa.razon_social}")
else:
    print("❌ Empresa no encontrada")
```

## 🗄️ Método 3: MySQL Directo

### Conectar directamente a MySQL:

```powershell
mysql -u root -h 127.0.0.1 -P 3307 coformacion1
```

### Comandos SQL de verificación:

```sql
-- 1. Verificar que estás en la base de datos correcta
SELECT DATABASE();

-- 2. Ver todas las tablas
SHOW TABLES;

-- 3. Contar estudiantes
SELECT COUNT(*) as total_estudiantes FROM estudiantes;

-- 4. Ver algunos estudiantes
SELECT estudiante_id, nombre_completo, numero_documento, estado 
FROM estudiantes 
LIMIT 5;

-- 5. Contar empresas
SELECT COUNT(*) as total_empresas FROM empresas;

-- 6. Ver algunas empresas
SELECT empresa_id, nombre_comercial, razon_social, nit, estado 
FROM empresas 
LIMIT 5;

-- 7. Verificar credenciales de login (estudiante)
SELECT nombre_completo, numero_documento 
FROM estudiantes 
WHERE nombre_completo LIKE '%María%' 
  AND numero_documento = '1234567891';

-- 8. Verificar credenciales de login (empresa)
SELECT nombre_comercial, razon_social, nit 
FROM empresas 
WHERE (nombre_comercial LIKE '%Soluciones%' OR razon_social LIKE '%Soluciones%')
  AND nit = '9001234567';

-- 9. Ver estructura de tabla estudiantes
DESCRIBE estudiantes;

-- 10. Ver estructura de tabla empresas
DESCRIBE empresas;
```

## 🧪 Método 4: Probar desde el Admin de Django

### 1. Crear un superusuario (si no existe):

```powershell
cd backendCoformacion
.\venv\Scripts\Activate.ps1
python manage.py createsuperuser
```

### 2. Acceder al admin:

1. Inicia el servidor: `python manage.py runserver 127.0.0.1:8000`
2. Abre en el navegador: `http://127.0.0.1:8000/admin`
3. Inicia sesión con el superusuario
4. Verifica que puedas ver las tablas:
   - Estudiantes
   - Empresas
   - Coformación

## 🔍 Método 5: Verificar en el Código

### Crear un endpoint de prueba temporal:

Agrega esto a `backendCoformacion/coformacion/views.py`:

```python
from django.http import JsonResponse
from django.db import connection
from coformacion.models import Estudiantes, Empresas

def test_db_connection(request):
    """Endpoint temporal para probar la conexión"""
    try:
        # Probar conexión
        with connection.cursor() as cursor:
            cursor.execute("SELECT 1")
            result = cursor.fetchone()
        
        # Contar registros
        estudiantes_count = Estudiantes.objects.count()
        empresas_count = Empresas.objects.count()
        
        return JsonResponse({
            'status': 'success',
            'connection': 'ok',
            'estudiantes_count': estudiantes_count,
            'empresas_count': empresas_count,
            'message': 'Base de datos conectada correctamente'
        })
    except Exception as e:
        return JsonResponse({
            'status': 'error',
            'message': str(e)
        }, status=500)
```

Agrega la ruta en `backendCoformacion/coformacion/urls.py`:

```python
path('test-db/', test_db_connection, name='test_db'),
```

Luego accede a: `http://127.0.0.1:8000/api/test-db/`

## ✅ Checklist de Verificación

Usa este checklist para verificar que todo esté correcto:

- [ ] El servidor Django inicia sin errores
- [ ] El script `test_database_connection.py` se ejecuta exitosamente
- [ ] Puedes conectarte a MySQL directamente
- [ ] Las tablas `estudiantes` y `empresas` existen
- [ ] Hay al menos algunos registros en las tablas
- [ ] Puedes hacer consultas desde Django shell
- [ ] El admin de Django muestra las tablas
- [ ] Las consultas de login funcionan correctamente

## 🚨 Problemas Comunes

### Error: "Can't connect to MySQL server"

**Solución:**
1. Verifica que MySQL esté corriendo
2. Verifica el puerto en `settings.py` (debería ser 3307)
3. Verifica que la base de datos `coformacion1` exista

### Error: "Table doesn't exist"

**Solución:**
```powershell
python manage.py migrate
```

### Error: "Access denied"

**Solución:**
1. Verifica el usuario y contraseña en `settings.py`
2. Verifica que el usuario tenga permisos:
```sql
GRANT ALL PRIVILEGES ON coformacion1.* TO 'root'@'localhost';
FLUSH PRIVILEGES;
```

### No hay datos en las tablas

**Solución:**
1. Ejecuta los scripts SQL de inicialización:
   - `backendCoformacion/agregar_estudiantes_prueba.sql`
   - `backendCoformacion/DBCoformacion.sql`

## 📊 Información Útil

### Ver configuración actual:

```python
from django.conf import settings
print(settings.DATABASES['default'])
```

### Ver conexión activa:

```python
from django.db import connection
print(connection.settings_dict)
```

### Verificar si hay migraciones pendientes:

```powershell
python manage.py showmigrations
```

### Aplicar migraciones:

```powershell
python manage.py migrate
```

## 🎯 Prueba Rápida

**Ejecuta esto para una verificación rápida:**

```powershell
cd backendCoformacion
.\venv\Scripts\Activate.ps1
python test_database_connection.py
```

Si todo está bien, deberías ver:
```
✅ Conexión exitosa a la base de datos!
✅ Se encontraron X tablas en la base de datos
✅ Estudiantes: X registros
✅ Empresas: X registros
✅ VERIFICACIÓN COMPLETA - Base de datos conectada correctamente
```


