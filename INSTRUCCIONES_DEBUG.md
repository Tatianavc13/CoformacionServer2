# Instrucciones para Debuggear el Error de Agregar Estudiante

## Pasos a Seguir:

### 1. **Recarga el navegador completamente**
   - Presiona: `Ctrl + Shift + R` (Windows/Linux) o `Cmd + Shift + R` (Mac)
   - Esto borra el caché y carga el código actualizado

### 2. **Abre las Herramientas de Desarrollador**
   - Presiona `F12` en el navegador
   - Dirígete a la pestaña **"Console"** (Consola)

### 3. **Navega a Agregar Estudiante**
   - Como usuario Coformador
   - Ve a: "Agregar Estudiante"

### 4. **Completa el formulario con estos datos de prueba:**

   **Información Personal:**
   - Código Estudiante: `TEST001`
   - Nombres: `Juan`
   - Apellidos: `Pérez`
   - Tipo Documento: `CC`
   - Número Documento: `80123456789`
   - Fecha Nacimiento: `2000-01-15`
   - Género: `Masculino`

   **Información de Contacto:**
   - Teléfono: (dejar vacío)
   - Celular: `3001234567`
   - Email Institucional: `juan.perez@test.edu.co`
   - Email Personal: (dejar vacío)
   - Dirección: (dejar vacío)
   - Ciudad: (dejar vacío)

   **Información Académica:**
   - Programa: `Ingeniería de Sistemas`
   - Semestre: `1`
   - Jornada: `Diurna`
   - Promedio Acumulado: (dejar vacío)
   - Estado: `Activo`
   - Fecha Ingreso: `2024-01-01`
   - Nivel Inglés: (dejar vacío)
   - Promoción: (dejar vacío)
   - Estado Cartera: (dejar vacío)

   **Información de Contacto de Emergencia:**
   - Nombres: `Maria`
   - Apellidos: `García`
   - Parentesco: `Madre`
   - Celular: `3213211789`
   - Teléfono: `6012345678`
   - Correo: `maria.garcia@gmail.com`

### 5. **Haz clic en "Guardar"**

### 6. **En la Consola (F12) busca:**

   **a) Un mensaje que diga:**
   ```
   "Enviando datos al servidor: {..."
   ```
   - Copia TODO este objeto JSON y compártelo conmigo

   **b) Busca mensajes de ERROR (en rojo):**
   - Si aparecen, copia el texto completo del error
   - Habrá un mensaje tipo: `Error guardando estudiante: ...`

   **c) Busca en la pestaña "Network":**
   - Haz clic en "Network" al lado de "Console"
   - Repite los pasos 4 y 5
   - Busca una solicitud POST a `/api/estudiantes/`
   - Haz clic sobre ella
   - Ve a la pestaña "Response" para ver la respuesta del servidor

### 7. **Comparte conmigo:**
   - El JSON que se está enviando (paso 6a)
   - Cualquier error que aparezca (paso 6b)
   - La respuesta del servidor si hay error (paso 6c)

---

## Posibles Problemas y Soluciones:

### Si ves error: "programa_id is not a valid integer"
→ El campo programa_id está llegando como string
→ La conversión a número NO está funcionando

### Si ves error: "This field may not be blank"
→ Un campo requerido está llegando vacío
→ Podría ser en contacto_emergencia

### Si ves error: "The field X is required"
→ Un campo obligatorio no se está enviando

---

## Información del Servidor:

Para verificar los logs del servidor Django:
1. Abre otra terminal
2. Ve al directorio del proyecto
3. Los logs de Django aparecerán en la consola donde está corriendo el servidor

Busca mensajes tipo: `POST /api/estudiantes/`
