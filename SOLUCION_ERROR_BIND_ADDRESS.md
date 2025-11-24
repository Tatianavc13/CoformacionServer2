# 🔧 Solución: Error "unknown variable 'bind-address=127.0.0.1'"

Este error generalmente ocurre cuando hay un problema con la configuración de MySQL o al intentar conectarse.

## 🔍 Causas Posibles

1. **Archivo de configuración de MySQL mal formado** (my.cnf o my.ini)
2. **Variable de configuración incorrecta** en MySQL
3. **Problema al ejecutar comandos MySQL** desde la línea de comandos
4. **Versión de MySQL incompatible** con la sintaxis usada

## ✅ Soluciones

### Solución 1: Probar Conexión Directa (Recomendado)

He creado un script que se conecta directamente a MySQL sin usar variables problemáticas:

```powershell
cd backendCoformacion
.\venv\Scripts\Activate.ps1
python test_db_simple.py
```

Este script:
- ✅ Se conecta directamente a MySQL usando mysql.connector
- ✅ No usa variables de configuración problemáticas
- ✅ Muestra información detallada de la conexión
- ✅ Verifica tablas y registros

### Solución 2: Probar desde Django Shell

```powershell
cd backendCoformacion
.\venv\Scripts\Activate.ps1
python manage.py shell
```

Luego ejecuta:

```python
from django.db import connection

# Probar conexión simple
try:
    with connection.cursor() as cursor:
        cursor.execute("SELECT 1")
        result = cursor.fetchone()
        print("✅ Conexión exitosa!")
        print(f"Resultado: {result}")
except Exception as e:
    print(f"❌ Error: {e}")
```

### Solución 3: Conectar Directamente con MySQL

```powershell
mysql -u root -h 127.0.0.1 -P 3307 coformacion1
```

**Si este comando falla**, el problema está en MySQL, no en Django.

### Solución 4: Verificar Configuración de MySQL

Si el error viene de un archivo de configuración de MySQL:

#### En Windows:
1. Busca el archivo `my.ini` (generalmente en `C:\ProgramData\MySQL\MySQL Server X.X\`)
2. Busca la línea que dice `bind-address=127.0.0.1`
3. Verifica que esté en la sección `[mysqld]`
4. La sintaxis correcta es:
```ini
[mysqld]
bind-address = 127.0.0.1
```

**O simplemente comenta la línea si no la necesitas:**
```ini
# bind-address = 127.0.0.1
```

#### En Linux/Mac:
1. Busca el archivo `my.cnf` (generalmente en `/etc/mysql/` o `/etc/my.cnf`)
2. Sigue los mismos pasos que en Windows

### Solución 5: Verificar que MySQL Esté Corriendo

```powershell
# Verificar si MySQL está corriendo
Get-Service | Where-Object {$_.Name -like "*mysql*"}

# O intentar iniciar MySQL
net start MySQL80
# (Ajusta el nombre del servicio según tu instalación)
```

### Solución 6: Usar localhost en lugar de 127.0.0.1

Si el problema persiste, intenta cambiar en `settings.py`:

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'coformacion1',
        'USER': 'root',
        'PASSWORD': '',
        'HOST': 'localhost',  # Cambiar de 127.0.0.1 a localhost
        'PORT': '3307',
        'OPTIONS': {
            'init_command': "SET sql_mode='STRICT_TRANS_TABLES'",
        }
    }
}
```

## 🧪 Prueba Rápida

**Ejecuta este comando para verificar la conexión:**

```powershell
cd backendCoformacion
.\venv\Scripts\Activate.ps1
python test_db_simple.py
```

**Si funciona**, verás:
```
✅ Conexión exitosa!
✅ Versión de MySQL: X.X.X
✅ Base de datos actual: coformacion1
✅ Estudiantes: X registros
✅ Empresas: X registros
```

## 🔍 Diagnóstico

### Si el script `test_db_simple.py` funciona:
✅ La conexión a MySQL está bien
✅ El problema está en otro lugar (posiblemente en cómo se ejecuta algún comando MySQL)

### Si el script `test_db_simple.py` falla:
❌ Hay un problema con:
- La conexión a MySQL
- Las credenciales
- El puerto
- La base de datos no existe

## 📝 Notas Importantes

1. **El error NO viene de Django**: Django usa `HOST` y `PORT` en settings.py, no `bind-address`
2. **bind-address es una configuración del servidor MySQL**, no del cliente
3. **Si estás en Windows**, el archivo de configuración es `my.ini`, no `my.cnf`
4. **El puerto 3307** es el que tienes configurado, verifica que MySQL esté escuchando en ese puerto

## 🆘 Si Nada Funciona

1. **Verifica que MySQL esté corriendo:**
   ```powershell
   mysql -u root -h 127.0.0.1 -P 3307 -e "SELECT 1"
   ```

2. **Verifica que la base de datos exista:**
   ```powershell
   mysql -u root -h 127.0.0.1 -P 3307 -e "SHOW DATABASES LIKE 'coformacion1'"
   ```

3. **Revisa los logs de MySQL** para ver si hay errores más específicos

4. **Intenta con el puerto por defecto (3306)** si 3307 no funciona:
   ```python
   'PORT': '3306',  # En lugar de 3307
   ```


