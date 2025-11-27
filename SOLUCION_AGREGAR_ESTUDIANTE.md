# Solución: Error al Agregar Estudiantes con Contacto de Emergencia

## Problema Identificado

Cuando intentabas agregar un estudiante desde la interfaz de coformador, recibías un error 400 (Bad Request). Esto se debía a que los campos con ID (Foreign Keys) se estaban enviando como **strings** en lugar de **números** desde el formulario Angular.

## Causa Raíz

En el archivo `agregar-estudiante.component.ts`, la función `guardarEstudiante()` convertía algunos campos numéricos pero NO convertía todos los IDs de las foreign keys:

```typescript
// ❌ ANTES - Incompleto
const estudianteData = {
  ...this.estudianteForm.value,
  semestre: parseInt(this.estudianteForm.value.semestre),
  promedio_acumulado: this.estudianteForm.value.promedio_acumulado ? parseFloat(this.estudianteForm.value.promedio_acumulado) : null
};
```

Faltaba convertir:
- `programa_id` ← **REQUIRED** (obligatorio)
- `nivel_ingles_id` ← opcional
- `promocion_id` ← opcional
- `estado_cartera_id` ← opcional

## Solución Aplicada

Se actualizó `agregar-estudiante.component.ts` para convertir todos los IDs a números:

```typescript
// ✅ DESPUÉS - Completo
const estudianteData = {
  ...this.estudianteForm.value,
  // Convertir todos los IDs a números
  programa_id: this.estudianteForm.value.programa_id ? parseInt(this.estudianteForm.value.programa_id) : null,
  nivel_ingles_id: this.estudianteForm.value.nivel_ingles_id ? parseInt(this.estudianteForm.value.nivel_ingles_id) : null,
  promocion_id: this.estudianteForm.value.promocion_id ? parseInt(this.estudianteForm.value.promocion_id) : null,
  estado_cartera_id: this.estudianteForm.value.estado_cartera_id ? parseInt(this.estudianteForm.value.estado_cartera_id) : null,
  // Otros campos numéricos
  semestre: parseInt(this.estudianteForm.value.semestre),
  promedio_acumulado: this.estudianteForm.value.promedio_acumulado ? parseFloat(this.estudianteForm.value.promedio_acumulado) : null
};
```

## Validación de la Solución

✅ El backend Django funciona correctamente - se validó con un test que:
- Aceptó correctamente la estructura de datos anidados
- Creó el estudiante exitosamente
- Creó el registro asociado en `contactos_de_emergencia` correctamente

✅ La tabla `contactos_de_emergencia` tiene:
- Relación correcta con `estudiantes` (ForeignKey)
- Todos los campos necesarios: `nombres`, `apellidos`, `parentesco`, `celular`, `telefono`, `correo`

## Pasos para Verificar

1. **Recarga el navegador** (Ctrl+Shift+R o Cmd+Shift+R) para cargar el código actualizado
2. **Intenta agregar un estudiante** nuevamente
3. **Completa todos los campos** incluyendo la "Información de Contacto de Emergencia":
   - Nombres del contacto
   - Apellidos del contacto
   - Parentesco (ej: Madre, Padre, Hermano, etc.)
   - Celular (requerido, formato: 10 dígitos)
   - Teléfono (opcional, formato: 7-10 dígitos)
   - Correo (opcional, debe ser un email válido)

## Campos Relacionados Verificados

### Frontend (Angular)
- ✅ Formulario reactivo en `agregar-estudiante.component.ts`
- ✅ Validadores en el HTML
- ✅ Estructura del formulario con grupo anidado `contacto_emergencia`

### Backend (Django)
- ✅ Modelo `Estudiantes` en `models.py`
- ✅ Modelo `ContactosDeEmergencia` en `models.py`
- ✅ Serializers configurados correctamente
- ✅ ViewSet de EstudiantesViewSet

## Notas Adicionales

Si aún experimentas problemas después de esta corrección, verifica:

1. **Que la migración fue aplicada**: 
   ```bash
   python manage.py migrate
   ```

2. **Que el servidor Django está ejecutándose** en el puerto esperado (8000 o 8001)

3. **En la consola del navegador (F12)**, revisa los detalles exactos del error 400 para identificar qué campo específicamente está causando el problema

4. **En los logs de Django**, busca mensajes de error más detallados sobre la validación

## Archivos Modificados

- `src/app/pages/agregar-estudiante/agregar-estudiante.component.ts` - Línea ~148 (función `guardarEstudiante()`)

---
Fecha: 27 de noviembre de 2025
