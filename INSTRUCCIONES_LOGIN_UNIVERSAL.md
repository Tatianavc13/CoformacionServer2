# Sistema de Login Universal - Coformación

## 🚀 Nueva Funcionalidad Implementada

Se ha implementado un **sistema de login inteligente** que detecta automáticamente si el usuario es un **estudiante** o una **empresa** y los redirige a su área correspondiente.

## 📋 Cómo Funciona

### Backend (Django)
- **Nuevo endpoint**: `POST /api/auth/login/`
- **Detección automática**: Busca primero en estudiantes, luego en empresas
- **Respuesta inteligente**: Incluye tipo de usuario y ruta de redirección

### Frontend (Angular)
- **Login unificado**: Un solo formulario para todos los usuarios
- **Redirección automática**: Según el tipo de usuario detectado
- **Interfaz mejorada**: Mensajes claros para estudiantes y empresas

## 🔐 Credenciales de Acceso

### Para Estudiantes
- **Campo 1**: Nombre completo del estudiante
- **Campo 2**: Número de documento (CC, CE, PAS, TI)
- **Redirección**: `/perfil-estudiante`

### Para Empresas
- **Campo 1**: Nombre de la empresa
- **Campo 2**: NIT de la empresa
- **Redirección**: `/informacion-empresa`

## 🌐 Endpoints Disponibles

### Login Universal
```
POST /api/auth/login/
Content-Type: application/json

{
  "nombre_completo": "Juan Pérez" | "Empresa XYZ",
  "numero_documento": "12345678" | "900123456"
}
```

### Respuesta Exitosa
```json
{
  "success": true,
  "message": "Login exitoso como estudiante|empresa",
  "data": { ...datos_del_usuario... },
  "tipo_usuario": "estudiante|empresa",
  "redirect_to": "/perfil-estudiante|/informacion-empresa"
}
```

### Respuesta de Error
```json
{
  "error": "Credenciales incorrectas. Verifique que sea un estudiante registrado o una empresa con convenio vigente."
}
```

## 🔄 Flujo de Autenticación

1. **Usuario ingresa credenciales** en el formulario unificado
2. **Sistema busca en estudiantes** primero
3. **Si no encuentra**, busca en empresas
4. **Si encuentra**, devuelve datos y tipo de usuario
5. **Frontend redirige automáticamente** a la página correspondiente

## 🎯 Rutas de Redirección

| Tipo Usuario | Ruta Destino | Descripción |
|--------------|--------------|-------------|
| `estudiante` | `/perfil-estudiante` | Perfil del estudiante |
| `empresa` | `/informacion-empresa` | Información de la empresa |

## 🔧 Compatibilidad

- **Endpoint anterior**: `/api/auth/login-estudiante/` sigue funcionando
- **Sin cambios**: Los estudiantes existentes pueden seguir usando el sistema
- **Retrocompatible**: No se rompe funcionalidad existente

## 🎨 Interfaz Actualizada

### Nuevos Elementos
- **Título**: "ACCESO AL SISTEMA"
- **Subtítulo**: "Estudiantes y Empresas"
- **Mensaje informativo**: Instrucciones claras para cada tipo de usuario
- **Labels actualizados**: "Nombre Completo / Nombre de Empresa" y "Número de Documento / NIT"

### Estilos Agregados
```css
.login-subtitle { /* Subtítulo del login */ }
.info-message { /* Mensaje informativo azul */ }
```

## 🚦 Códigos de Estado

| Código | Significado |
|--------|-------------|
| `200` | Login exitoso |
| `400` | Datos requeridos faltantes |
| `401` | Credenciales incorrectas |
| `500` | Error interno del servidor |

## 📝 Próximos Pasos

Una vez que implementes el **tercer tipo de usuario** (coformación), simplemente:

1. Agregar lógica en `login_universal()` para buscar en la tabla de usuarios de coformación
2. Definir la ruta de redirección en `app.routes.ts`
3. El sistema detectará automáticamente el tercer tipo

## 🧪 Pruebas

### Probar como Estudiante
```bash
curl -X POST http://localhost:8000/api/auth/login/ \
  -H "Content-Type: application/json" \
  -d '{"nombre_completo": "Juan Estudiante", "numero_documento": "12345678"}'
```

### Probar como Empresa
```bash
curl -X POST http://localhost:8000/api/auth/login/ \
  -H "Content-Type: application/json" \
  -d '{"nombre_completo": "Mi Empresa", "numero_documento": "900123456"}'
```

## ✅ Beneficios

1. **Una sola página de login** para todos los usuarios
2. **Detección automática** del tipo de usuario
3. **Experiencia mejorada** sin necesidad de seleccionar tipo manualmente
4. **Escalable** para agregar más tipos de usuario
5. **Retrocompatible** con sistema existente

¡El sistema ya está listo para detectar automáticamente estudiantes y empresas! 🎉 