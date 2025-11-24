# 🔍 Verificar Credenciales en la Base de Datos

Este documento te ayuda a verificar qué credenciales están disponibles en tu base de datos MySQL para poder iniciar sesión.

## 📋 Requisitos

- Acceso a MySQL (puerto 3307 según tu configuración)
- Base de datos: `coformacion1`
- Usuario: `root` (sin contraseña según tu settings.py)

## 🔐 Consultas SQL para Verificar Credenciales

### 1. Verificar Estudiantes Disponibles

```sql
USE coformacion1;

-- Ver todos los estudiantes con sus credenciales de login
SELECT 
    estudiante_id,
    nombre_completo,
    numero_documento,
    tipo_documento,
    codigo_estudiante,
    estado
FROM estudiantes
WHERE estado = 'Activo'
ORDER BY nombre_completo;
```

**Campos para login:**
- **Campo 1 (nombre)**: `nombre_completo`
- **Campo 2 (identificación)**: `numero_documento`

### 2. Verificar Empresas Disponibles

```sql
USE coformacion1;

-- Ver todas las empresas con sus credenciales de login
SELECT 
    empresa_id,
    nombre_comercial,
    razon_social,
    nit,
    estado_convenio,
    estado
FROM empresas
WHERE estado = 1
ORDER BY nombre_comercial;
```

**Campos para login:**
- **Campo 1 (nombre)**: `nombre_comercial` O `razon_social` (cualquiera de los dos funciona)
- **Campo 2 (identificación)**: `nit`

### 3. Verificar Usuarios de Coformación (si existen)

```sql
USE coformacion1;

-- Ver usuarios de coformación
SELECT 
    coformacion_id,
    nombre_completo,
    identificacion
FROM coformacion
ORDER BY nombre_completo;
```

**Campos para login:**
- **Campo 1 (nombre)**: `nombre_completo`
- **Campo 2 (identificación)**: `identificacion`

## 🧪 Probar Credenciales Específicas

### Probar un Estudiante Específico

```sql
-- Reemplaza 'María González' y '1234567891' con los datos que quieras probar
SELECT 
    estudiante_id,
    nombre_completo,
    numero_documento,
    estado
FROM estudiantes
WHERE nombre_completo LIKE '%María González%'
  AND numero_documento = '1234567891';
```

### Probar una Empresa Específica

```sql
-- Reemplaza 'Soluciones Digitales' y '9001234567' con los datos que quieras probar
SELECT 
    empresa_id,
    nombre_comercial,
    razon_social,
    nit,
    estado
FROM empresas
WHERE (nombre_comercial LIKE '%Soluciones Digitales%' 
    OR razon_social LIKE '%Soluciones Digitales%')
  AND nit = '9001234567';
```

## 🔍 Diagnóstico de Problemas

### Si no encuentras ningún estudiante:

```sql
-- Verificar si la tabla estudiantes existe y tiene datos
SELECT COUNT(*) as total_estudiantes FROM estudiantes;

-- Ver estructura de la tabla
DESCRIBE estudiantes;
```

### Si no encuentras ninguna empresa:

```sql
-- Verificar si la tabla empresas existe y tiene datos
SELECT COUNT(*) as total_empresas FROM empresas;

-- Ver estructura de la tabla
DESCRIBE empresas;
```

### Verificar que los datos estén correctos:

```sql
-- Verificar estudiantes con datos nulos o vacíos
SELECT 
    estudiante_id,
    nombre_completo,
    numero_documento
FROM estudiantes
WHERE nombre_completo IS NULL 
   OR nombre_completo = ''
   OR numero_documento IS NULL
   OR numero_documento = '';

-- Verificar empresas con datos nulos o vacíos
SELECT 
    empresa_id,
    nombre_comercial,
    razon_social,
    nit
FROM empresas
WHERE (nombre_comercial IS NULL OR nombre_comercial = '')
  AND (razon_social IS NULL OR razon_social = '')
   OR nit IS NULL
   OR nit = '';
```

## 📝 Ejemplos de Credenciales Válidas

### Ejemplo 1: Estudiante
```sql
-- Buscar estudiantes activos
SELECT nombre_completo, numero_documento 
FROM estudiantes 
WHERE estado = 'Activo' 
LIMIT 5;
```

**Resultado esperado:**
```
nombre_completo    | numero_documento
-------------------|----------------
María González     | 1234567891
Carlos Rodríguez   | 1234567892
```

**Para login usar:**
- Nombre: `María González`
- Documento: `1234567891`

### Ejemplo 2: Empresa
```sql
-- Buscar empresas activas
SELECT nombre_comercial, razon_social, nit 
FROM empresas 
WHERE estado = 1 
LIMIT 5;
```

**Resultado esperado:**
```
nombre_comercial          | razon_social              | nit
--------------------------|---------------------------|------------
Soluciones Digitales S.A.S| Soluciones Digitales S.A.S| 9001234567
```

**Para login usar:**
- Nombre: `Soluciones Digitales S.A.S` (o `SolDigital`)
- NIT: `9001234567`

## ⚠️ Notas Importantes

1. **Búsqueda Parcial**: El sistema busca con `LIKE` (búsqueda parcial), así que puedes usar parte del nombre
   - Ejemplo: `María` en lugar de `María González` también funcionará

2. **Mayúsculas/Minúsculas**: La búsqueda es case-insensitive (`icontains` en Django)
   - `maría gonzález` funciona igual que `María González`

3. **Espacios**: Los espacios al inicio y final se eliminan automáticamente

4. **NIT de Empresas**: Debe coincidir exactamente (sin guiones)
   - Si en la BD está `800987654-3`, intenta con `8009876543` o `800987654-3`

5. **Estado**: Solo funcionan usuarios/empresas con estado activo
   - Estudiantes: `estado = 'Activo'`
   - Empresas: `estado = 1` (o `True`)

## 🚀 Comandos Rápidos

### Conectar a MySQL desde terminal:

```bash
mysql -u root -h 127.0.0.1 -P 3307 coformacion1
```

### O desde PowerShell:

```powershell
mysql -u root -h 127.0.0.1 -P 3307 coformacion1
```

### Ejecutar consulta rápida:

```sql
-- Ver primeros 3 estudiantes
SELECT nombre_completo, numero_documento FROM estudiantes LIMIT 3;

-- Ver primeras 3 empresas
SELECT nombre_comercial, nit FROM empresas LIMIT 3;
```

## 🔧 Si No Hay Datos

Si las consultas no devuelven resultados, necesitas insertar datos de prueba:

1. **Para estudiantes**: Ejecuta `backendCoformacion/agregar_estudiantes_prueba.sql`
2. **Para empresas**: Los datos deberían estar en `backendCoformacion/DBCoformacion.sql`

```sql
-- Verificar si hay datos
SELECT COUNT(*) FROM estudiantes;
SELECT COUNT(*) FROM empresas;
```

Si ambos devuelven 0, necesitas ejecutar los scripts SQL de inicialización.


