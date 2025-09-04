# Instrucciones para Conectar Backend y Frontend

## ✅ Estado de la Conexión

El proyecto ha sido **completamente conectado** entre el backend Django y el frontend Angular. Los componentes principales ahora obtienen datos reales del backend.

## 🚀 Instrucciones de Ejecución

### 1. Ejecutar el Backend Django

```bash
# Navegar a la carpeta del backend
cd backendCoformacion

# Activar el entorno virtual (si tienes uno)
# source venv/bin/activate  # En Linux/Mac
# venv\Scripts\activate     # En Windows

# Instalar dependencias (si es necesario)
pip install django djangorestframework django-cors-headers

# Ejecutar migraciones (si es necesario)
python manage.py migrate

# Iniciar el servidor
python manage.py runserver
```

El backend estará disponible en: `http://127.0.0.1:8000`

### 2. Ejecutar el Frontend Angular

```bash
# En una nueva terminal, desde la raíz del proyecto
npm install

# Iniciar el servidor de desarrollo
ng serve
```

El frontend estará disponible en: `http://localhost:4200`

## 🔧 Verificar la Conexión

### Página de Diagnóstico
Visita: `http://localhost:4200/diagnostico`

Esta página te permite:
- ✅ Probar la conexión con el backend
- ✅ Verificar todos los endpoints de la API
- ✅ Ver el estado de cada servicio
- ✅ Contar registros en cada tabla

### Páginas Conectadas

Las siguientes páginas ahora están **completamente conectadas** al backend:

#### 📊 Consulta de Estudiantes (`/consult-estudent`)
- ✅ Muestra estudiantes reales del backend
- ✅ Filtros por programa, promoción, nivel de inglés, estado de cartera
- ✅ Búsqueda por nombre, documento o correo
- ✅ Indicadores de carga y error
- ✅ Muestra datos relacionados (programa, facultad, etc.)

#### 🏢 Consulta de Empresas (`/consult-empresa`)
- ✅ Muestra empresas reales del backend
- ✅ Filtros por sector económico y tamaño
- ✅ Búsqueda por nombre o NIT
- ✅ Cuenta de contactos por empresa
- ✅ Indicadores de carga y error

#### 📋 Proceso de Coformación (`/proceso-coformacion`)
- ✅ Formulario conectado para crear/editar procesos
- ✅ Selección de estudiantes, empresas y ofertas reales
- ✅ Validación de formulario
- ✅ Guardado en base de datos
- ✅ Filtrado dinámico de ofertas por empresa

## 📡 APIs Disponibles

El backend expone las siguientes APIs REST:

| Endpoint | URL | Descripción |
|----------|-----|-------------|
| Estudiantes | `/api/estudiantes/` | CRUD de estudiantes |
| Empresas | `/api/empresas/` | CRUD de empresas |
| Programas | `/api/programas/` | CRUD de programas académicos |
| Facultades | `/api/facultades/` | CRUD de facultades |
| Promociones | `/api/promociones/` | CRUD de promociones |
| Tipos Documento | `/api/tipos-documento/` | Tipos de documento |
| Niveles Inglés | `/api/niveles-ingles/` | Niveles de inglés |
| Estados Cartera | `/api/estados-cartera/` | Estados de cartera |
| Sectores Económicos | `/api/sectores-economicos/` | Sectores económicos |
| Tamaños Empresa | `/api/tamanos-empresa/` | Tamaños de empresa |
| Contactos Empresa | `/api/contactos-empresa/` | Contactos de empresas |
| Ofertas Empresas | `/api/ofertas-empresas/` | Ofertas de coformación |
| Proceso Coformación | `/api/proceso-coformacion/` | Procesos de coformación |
| Estado Proceso | `/api/estado-proceso/` | Estados de proceso |

## 🏗️ Arquitectura Implementada

### Backend (Django)
- ✅ Modelos definidos en `models.py`
- ✅ Serializers para API REST en `serializers.py`
- ✅ ViewSets con operaciones CRUD en `views.py`
- ✅ URLs configuradas en `urls.py`
- ✅ CORS habilitado para desarrollo

### Frontend (Angular)
- ✅ **Servicios**: Uno por cada entidad del backend
- ✅ **Interfaces**: TypeScript interfaces que coinciden con modelos Django
- ✅ **Componentes**: Actualizados para usar datos reales
- ✅ **Configuración HTTP**: Cliente HTTP configurado
- ✅ **Manejo de Errores**: Indicadores de carga y mensajes de error
- ✅ **Filtros y Búsqueda**: Funcionalidad completa implementada

### Servicios Centralizados
- ✅ **ApiConfigService**: Configuración centralizada de URLs
- ✅ **BackendTestService**: Pruebas de conectividad
- ✅ **Servicios por Entidad**: 25 servicios individuales

## 🎯 Funcionalidades Implementadas

### Consulta de Estudiantes
- [x] Listado completo de estudiantes
- [x] Filtros avanzados (programa, promoción, etc.)
- [x] Búsqueda en tiempo real
- [x] Paginación visual
- [x] Información relacionada (facultad, programa)
- [x] Indicadores de estado

### Consulta de Empresas
- [x] Listado completo de empresas
- [x] Filtros por sector y tamaño
- [x] Búsqueda por nombre/NIT
- [x] Conteo de contactos
- [x] Navegación a detalles

### Proceso de Coformación
- [x] Formulario dinámico
- [x] Validación de campos
- [x] Relaciones entre entidades
- [x] Guardado en base de datos
- [x] Modo crear/editar

## 🛠️ Solución de Problemas

### Error de Conexión
Si ves errores de conexión:
1. Verifica que Django esté ejecutándose en `http://127.0.0.1:8000`
2. Visita `http://localhost:4200/diagnostico` para hacer pruebas
3. Revisa la consola del navegador para errores CORS

### Base de Datos Vacía
Si no ves datos:
1. Ejecuta las migraciones: `python manage.py migrate`
2. Crea datos de prueba desde el admin de Django: `http://127.0.0.1:8000/admin`
3. O usa el shell de Django para crear datos

### Problemas de CORS
Si hay errores CORS, verifica que Django tenga configurado:
```python
# settings.py
CORS_ALLOW_ALL_ORIGINS = True  # Solo para desarrollo
```

## 🎉 Próximos Pasos

El proyecto está listo para:
1. **Agregar más componentes**: Otros componentes pueden seguir el mismo patrón
2. **Implementar autenticación**: JWT tokens o sesiones Django
3. **Optimizar rendimiento**: Paginación del lado del servidor
4. **Añadir validaciones**: Más validaciones tanto en frontend como backend
5. **Despliegue**: Configurar para producción

## 📞 Soporte

Si encuentras algún problema:
1. Revisa la página de diagnóstico (`/diagnostico`)
2. Verifica que ambos servidores estén ejecutándose
3. Revisa las consolas de error tanto en el navegador como en Django

¡La conexión entre backend y frontend está **completamente funcional**! 🚀 