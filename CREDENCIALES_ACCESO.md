# 🔐 Credenciales de Acceso - Sistema de Coformación

Este documento contiene todas las credenciales disponibles para probar el sistema de login.

## 📋 Sistema de Login Universal

El sistema detecta automáticamente si eres **estudiante**, **empresa** o **usuario de coformación** basándose en las credenciales ingresadas.

### Formato de Login
- **Campo 1**: Nombre completo (estudiante) / Nombre de empresa (empresa)
- **Campo 2**: Número de documento (estudiante) / NIT (empresa)

---

## 👨‍🎓 Credenciales de Estudiantes

### Estudiante 1
- **Nombre Completo**: `María González`
- **Número de Documento**: `1234567891`
- **Redirección**: `/perfil-estudiante`

### Estudiante 2
- **Nombre Completo**: `Carlos Rodríguez`
- **Número de Documento**: `1234567892`
- **Redirección**: `/perfil-estudiante`

### Estudiante 3
- **Nombre Completo**: `Ana Martínez`
- **Número de Documento**: `1234567893`
- **Redirección**: `/perfil-estudiante`

### Estudiante 4
- **Nombre Completo**: `Luis Hernández`
- **Número de Documento**: `1234567894`
- **Redirección**: `/perfil-estudiante`

### Estudiante 5
- **Nombre Completo**: `Isabella Torres`
- **Número de Documento**: `1234567895`
- **Redirección**: `/perfil-estudiante`

### Estudiante 6
- **Nombre Completo**: `Sebastián Vargas`
- **Número de Documento**: `1234567896`
- **Redirección**: `/perfil-estudiante`

### Estudiante 7
- **Nombre Completo**: `Camila Jiménez`
- **Número de Documento**: `1234567897`
- **Redirección**: `/perfil-estudiante`

### Estudiante 8
- **Nombre Completo**: `Andrés Morales`
- **Número de Documento**: `1234567898`
- **Redirección**: `/perfil-estudiante`

### Estudiante 9
- **Nombre Completo**: `Valentina Castro`
- **Número de Documento**: `1234567899`
- **Redirección**: `/perfil-estudiante`

---

## 🏢 Credenciales de Empresas

### Empresa 1 - Soluciones Digitales S.A.S.
- **Nombre Comercial**: `Soluciones Digitales S.A.S.` o `SolDigital`
- **Razón Social**: `Soluciones Digitales S.A.S.`
- **NIT**: `9001234567`
- **Estado Convenio**: Vigente
- **Redirección**: `/home-empresa`

### Empresa 2 - Instituto Latino de Educación
- **Nombre Comercial**: `Instituto Latino de Educación` o `ILEDUC`
- **Razón Social**: `Instituto Latino de Educación`
- **NIT**: (No especificado en base de datos)
- **Estado Convenio**: En Trámite
- **Redirección**: `/home-empresa`

### Empresa 3 - Constructora El Pilar S.A.S
- **Nombre Comercial**: `El Pilar`
- **Razón Social**: `Constructora El Pilar S.A.S`
- **NIT**: `9001234567`
- **Estado Convenio**: Vigente
- **Redirección**: `/home-empresa`

### Empresa 4 - Industrias La Montaña S.A.
- **Nombre Comercial**: `La Montaña`
- **Razón Social**: `Industrias La Montaña S.A.`
- **NIT**: `800987654-3` o `8009876543`
- **Estado Convenio**: Vigente
- **Redirección**: `/home-empresa`

### Empresa 5 - Transportes Nacionales Ltda.
- **Nombre Comercial**: `TransNac`
- **Razón Social**: `Transportes Nacionales Ltda.`
- **NIT**: `901222333-1` o `9012223331`
- **Estado Convenio**: En Trámite
- **Redirección**: `/home-empresa`

### Empresa 6 - Soluciones Digitales S.A.S. (Alternativa)
- **Nombre Comercial**: `Soluciones Digitales S.A.S.`
- **NIT**: `9001234567`
- **Estado Convenio**: En Trámite
- **Redirección**: `/home-empresa`

### Empresa 7 - Transportes Rápidos S.A.
- **Nombre Comercial**: `Transportes Rápidos S.A.`
- **NIT**: `8901234569`
- **Estado Convenio**: En Trámite
- **Redirección**: `/home-empresa`

### Empresa 8 - Marketing Innova SAS
- **Nombre Comercial**: `Marketing Innova SAS`
- **NIT**: `9009876543`
- **Estado Convenio**: En Trámite
- **Redirección**: `/home-empresa`

### Empresa 9 - El Sabor Casero Ltda.
- **Nombre Comercial**: `El Sabor Casero Ltda.`
- **NIT**: `8001122330`
- **Estado Convenio**: En Trámite
- **Redirección**: `/home-empresa`

### Empresa 10 - Confecciones Moda Total
- **Nombre Comercial**: `Confecciones Moda Total`
- **NIT**: `7776665554`
- **Estado Convenio**: En Trámite
- **Redirección**: `/home-empresa`

### Empresa 11 - Salsas
- **Nombre Comercial**: `Salsas`
- **Razón Social**: `SALSA S.A.S`
- **NIT**: `9102391009`
- **Estado Convenio**: En Trámite
- **Redirección**: `/home-empresa`

### Empresa 12 - GANADO RICHI
- **Nombre Comercial**: `GANADO RICHI`
- **Razón Social**: `GANADEROS`
- **NIT**: `9003212839`
- **Estado Convenio**: Vigente
- **Redirección**: `/home-empresa`

---

## 🔧 Notas Importantes

### Para Estudiantes
- El sistema busca por **nombre completo** (búsqueda parcial, no exacta)
- El **número de documento** debe coincidir exactamente
- Puedes usar el nombre completo o parte de él

### Para Empresas
- El sistema busca por **nombre comercial** o **razón social** (búsqueda parcial)
- El **NIT** debe coincidir exactamente
- Puedes usar el nombre comercial o la razón social

### Orden de Búsqueda
El sistema intenta encontrar el usuario en este orden:
1. **Usuarios de Coformación** (si existen)
2. **Estudiantes**
3. **Empresas**

### Ejemplos de Uso

#### Como Estudiante:
```
Campo 1: María González
Campo 2: 1234567891
```

#### Como Empresa:
```
Campo 1: Soluciones Digitales S.A.S.
Campo 2: 9001234567
```

O también:
```
Campo 1: SolDigital
Campo 2: 9001234567
```

---

## 🚨 Solución de Problemas

### Error: "Credenciales incorrectas"
1. Verifica que el nombre esté escrito correctamente (puede ser parcial)
2. Verifica que el número de documento/NIT esté exacto
3. Asegúrate de que el usuario exista en la base de datos

### El sistema no encuentra el usuario
- Verifica que la base de datos esté correctamente configurada
- Ejecuta las migraciones: `python manage.py migrate`
- Verifica que los datos estén en la base de datos

---

## 📝 Endpoint de API

### Login Universal
```
POST http://localhost:8000/api/auth/login/
Content-Type: application/json

{
  "nombre_completo": "María González",
  "numero_documento": "1234567891"
}
```

### Respuesta Exitosa
```json
{
  "success": true,
  "message": "Login exitoso como estudiante",
  "data": { ...datos_del_usuario... },
  "tipo_usuario": "estudiante",
  "redirect_to": "/perfil-estudiante"
}
```

---

## 🔗 URLs de Acceso

- **Frontend**: http://localhost:4201
- **Backend API**: http://localhost:8001/api
- **Admin Django**: http://localhost:8001/admin

---

**Última actualización**: Noviembre 2025


