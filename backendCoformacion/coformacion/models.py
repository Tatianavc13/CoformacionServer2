from django.db import models


class Roles(models.Model):
    rol_id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=50)
    descripcion = models.TextField(blank=True, null=True)
    estado = models.BooleanField(default=True)
    fecha_creacion = models.DateTimeField(blank=True, null=True)
    fecha_actualizacion = models.DateTimeField(blank=True, null=True)

    class Meta:
        db_table = 'roles'


class Permisos(models.Model):
    permiso_id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=100)
    modulo = models.CharField(max_length=50)
    descripcion = models.TextField(blank=True, null=True)
    estado = models.BooleanField(default=True)
    fecha_creacion = models.DateTimeField(blank=True, null=True)

    class Meta:
        db_table = 'permisos'


class RolesPermisos(models.Model):
    rol = models.ForeignKey(Roles, on_delete=models.DO_NOTHING)
    permiso = models.ForeignKey(Permisos, on_delete=models.DO_NOTHING)
    fecha_asignacion = models.DateTimeField(blank=True, null=True)

    class Meta:
        db_table = 'roles_permisos'
        unique_together = (('rol', 'permiso'),)

class TiposDocumento(models.Model):
    tipo_doc_id = models.AutoField(primary_key=True)
    codigo = models.CharField(max_length=20, unique=True)
    nombre = models.CharField(max_length=100)
    descripcion = models.TextField(blank=True, null=True)
    es_obligatorio = models.BooleanField(default=True)
    formato_url = models.CharField(max_length=255, blank=True, null=True)
    estado = models.BooleanField(default=True)
    fecha_creacion = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'tipos_documento'


class Facultades(models.Model):
    facultad_id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=255)
    estado = models.BooleanField(default=True)
    fecha_creacion = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'facultades'


class Programas(models.Model):
    MODALIDAD_CHOICES = [
        ('Presencial', 'Presencial'),
        ('Virtual', 'Virtual'),
        ('Híbrido', 'Híbrido'),
    ]

    NIVEL_CHOICES = [
        ('Técnico', 'Técnico'),
        ('Tecnólogo', 'Tecnólogo'),
        ('Profesional', 'Profesional'),
        ('Especialización', 'Especialización'),
        ('Maestría', 'Maestría'),
    ]

    programa_id = models.AutoField(primary_key=True)
    codigo = models.CharField(max_length=20, unique=True)
    nombre = models.CharField(max_length=255)
    facultad_id = models.ForeignKey('Facultades', on_delete=models.RESTRICT, db_column='facultad_id')
    duracion_semestres = models.IntegerField()
    modalidad = models.CharField(max_length=10, choices=MODALIDAD_CHOICES)
    nivel = models.CharField(max_length=15, choices=NIVEL_CHOICES)
    resolucion_registro = models.CharField(max_length=100, blank=True, null=True)
    fecha_resolucion = models.DateField(blank=True, null=True)
    estado = models.BooleanField(default=True)
    fecha_creacion = models.DateTimeField(auto_now_add=True)
    fecha_actualizacion = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = 'programas'


class MateriasNucleo(models.Model):
    materia_id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=100)
    programa = models.ForeignKey(Programas, on_delete=models.DO_NOTHING)

    class Meta:
        db_table = 'materias_nucleo'


class ObjetivosAprendizaje(models.Model):
    objetivo_id = models.AutoField(primary_key=True)
    descripcion = models.TextField()
    materia = models.ForeignKey(MateriasNucleo, on_delete=models.DO_NOTHING)

    class Meta:
        db_table = 'objetivos_aprendizaje'


class Promociones(models.Model):
    promocion_id = models.AutoField(primary_key=True)
    descripcion = models.CharField(max_length=50, unique=True)

    class Meta:
        db_table = 'promociones'


class NivelesIngles(models.Model):
    nivel_id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=50, unique=True)

    class Meta:
        db_table = 'niveles_ingles'


class EstadosCartera(models.Model):
    estado_id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=50, unique=True)

    class Meta:
        db_table = 'estados_cartera'


class Coformacion(models.Model):
    id = models.AutoField(primary_key=True)
    nombre_completo = models.CharField(max_length=255)
    identificacion = models.CharField(max_length=20, unique=True)
    rol = models.CharField(max_length=100)
    estado = models.BooleanField(default=True)
    fecha_creacion = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'coformacion'


class Estudiantes(models.Model):
    TIPO_DOCUMENTO_CHOICES = [
        ('CC', 'Cédula de Ciudadanía'),
        ('CE', 'Cédula de Extranjería'),
        ('PAS', 'Pasaporte'),
        ('TI', 'Tarjeta de Identidad'),
    ]

    GENERO_CHOICES = [
        ('M', 'Masculino'),
        ('F', 'Femenino'),
        ('O', 'Otro'),
    ]

    JORNADA_CHOICES = [
        ('Diurna', 'Diurna'),
        ('Nocturna', 'Nocturna'),
        ('Mixta', 'Mixta'),
    ]

    ESTADO_CHOICES = [
        ('Activo', 'Activo'),
        ('Inactivo', 'Inactivo'),
        ('Graduado', 'Graduado'),
        ('Retirado', 'Retirado'),
    ]

    estudiante_id = models.AutoField(primary_key=True)
    codigo_estudiante = models.CharField(max_length=20, unique=True)
    nombre_completo = models.CharField(max_length=255)
    tipo_documento = models.CharField(max_length=3, choices=TIPO_DOCUMENTO_CHOICES)
    numero_documento = models.CharField(max_length=20, unique=True)
    fecha_nacimiento = models.DateField()
    genero = models.CharField(max_length=1, choices=GENERO_CHOICES)
    telefono = models.CharField(max_length=20, blank=True, null=True)
    celular = models.CharField(max_length=20)
    email_institucional = models.EmailField(unique=True)
    email_personal = models.EmailField(blank=True, null=True)
    direccion = models.CharField(max_length=255, blank=True, null=True)
    ciudad = models.CharField(max_length=100, blank=True, null=True)
    foto_url = models.CharField(max_length=255, blank=True, null=True)
    programa_id = models.ForeignKey('Programas', on_delete=models.RESTRICT, db_column='programa_id')
    semestre = models.IntegerField()
    jornada = models.CharField(max_length=8, choices=JORNADA_CHOICES)
    promedio_acumulado = models.DecimalField(max_digits=3, decimal_places=2, blank=True, null=True)
    estado = models.CharField(max_length=9, choices=ESTADO_CHOICES, default='Activo')
    fecha_ingreso = models.DateField()
    fecha_creacion = models.DateTimeField(auto_now_add=True)
    fecha_actualizacion = models.DateTimeField(auto_now=True)
    nivel_ingles_id = models.ForeignKey('NivelesIngles', on_delete=models.SET_NULL, null=True, blank=True, db_column='nivel_ingles_id')
    estado_cartera_id = models.ForeignKey('EstadosCartera', on_delete=models.SET_NULL, null=True, blank=True, db_column='estado_cartera_id')
    promocion_id = models.ForeignKey('Promociones', on_delete=models.SET_NULL, null=True, blank=True, db_column='promocion_id')
    empresa_id = models.ForeignKey('Empresas', on_delete=models.SET_NULL, null=True, blank=True, db_column='empresa_id')

    class Meta:
        db_table = 'estudiantes'


class SectoresEconomicos(models.Model):
    sector_id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=100)

    class Meta:
        db_table = 'sectores_economicos'


class TamanosEmpresa(models.Model):
    tamano_id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=100)

    class Meta:
        db_table = 'tamanos_empresa'


class Empresas(models.Model):
    empresa_id = models.AutoField(primary_key=True)
    razon_social = models.CharField(max_length=255)
    nombre_comercial = models.CharField(max_length=255, blank=True, null=True)
    sector = models.ForeignKey('SectoresEconomicos', on_delete=models.RESTRICT, db_column='sector_id')
    tamano = models.ForeignKey('TamanosEmpresa', on_delete=models.RESTRICT, db_column='tamano_id')
    direccion = models.CharField(max_length=255, db_column='direccion_empresa')
    ciudad = models.CharField(max_length=100, db_column='ciudad_empresa')
    ciudad_duplicada = models.CharField(max_length=100, db_column='ciudad')  # Columna adicional 'ciudad' en la BD
    departamento = models.CharField(max_length=100, db_column='departamento_empresa')
    telefono = models.CharField(max_length=20, blank=True, null=True, db_column='telefono_empresa')
    email_empresa = models.CharField(max_length=255, blank=True, null=True, db_column='email_empresa')
    sitio_web = models.CharField(max_length=255, blank=True, null=True)
    cuota_sena = models.IntegerField(blank=True, null=True)
    numero_empleados = models.IntegerField(blank=True, null=True)
    nombre_persona_contacto_empresa = models.CharField(max_length=255, db_column='nombre_persona_contacto_empresa')
    numero_persona_contacto_empresa = models.CharField(max_length=255, blank=True, null=True, db_column='numero_persona_contacto_empresa')
    cargo_persona_contacto_empresa = models.CharField(max_length=255, db_column='cargo_persona_contacto_empresa')
    ESTADO_CONVENIO_CHOICES = [
        ('Vigente', 'Vigente'),
        ('No Vigente', 'No Vigente'),
        ('En Trámite', 'En Trámite'),
    ]
    estado_convenio = models.CharField(max_length=20, choices=ESTADO_CONVENIO_CHOICES, default='En Trámite')
    fecha_convenio = models.DateField(blank=True, null=True)
    convenio_url = models.CharField(max_length=255, blank=True, null=True)
    actividad_economica = models.TextField()
    horario_laboral = models.TextField(blank=True, null=True)
    trabaja_sabado = models.BooleanField(default=False)
    observaciones = models.TextField(blank=True, null=True)
    estado = models.BooleanField(default=True)
    fecha_creacion = models.DateTimeField(auto_now_add=True)
    fecha_actualizacion = models.DateTimeField(auto_now=True)
    nit = models.CharField(max_length=20, blank=True, null=True, db_column='nit_empresa')
    imagen_url_base64 = models.TextField(blank=True, null=True, db_column='imagen_url_base64')
    # logo_url = models.CharField(max_length=255, blank=True, null=True, db_column='logo_url')  # Comentado temporalmente hasta ejecutar migración

    class Meta:
        db_table = 'empresas'
        indexes = [
            models.Index(fields=['sector', 'estado_convenio'], name='idx_empresa_sector'),
            models.Index(fields=['estado_convenio', 'estado'], name='idx_empresa_estado'),
        ]


class TiposContacto(models.Model):
    tipo_id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=50, unique=True)

    class Meta:
        db_table = 'tipos_contacto'


class ContactosEmpresa(models.Model):
    contacto_id = models.AutoField(primary_key=True)
    empresa_id = models.ForeignKey(Empresas, on_delete=models.CASCADE, db_column='empresa_id')
    nombre = models.CharField(max_length=100)
    cargo = models.CharField(max_length=100, blank=True, null=True)
    area = models.CharField(max_length=100, blank=True, null=True)
    telefono = models.CharField(max_length=20, blank=True, null=True)
    celular = models.CharField(max_length=20, blank=True, null=True)
    email = models.EmailField()
    tipo = models.CharField(max_length=50, blank=True, null=True)
    es_principal = models.BooleanField(default=False)
    estado = models.BooleanField(default=True)
    fecha_creacion = models.DateTimeField(auto_now_add=True)
    fecha_actualizacion = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = 'contactos_empresa'


class OfertasEmpresas(models.Model):
    NACIONAL_CHOICES = [
        ('No', 'No'),
        ('Si', 'Si'),
    ]

    MODALIDAD_CHOICES = [
        ('Presencial', 'Presencial'),
        ('Virtual', 'Virtual'),
        ('Híbrido', 'Híbrido'),
    ]

    TIPO_OFERTA_CHOICES = [
        ('Nacional', 'Nacional'),
        ('Internacional', 'Internacional'),
    ]

    APOYO_ECONOMICO_CHOICES = [
        ('Si', 'Si'),
        ('No', 'No'),
    ]

    idOferta = models.AutoField(primary_key=True, db_column='idOferta')
    nacional = models.CharField(max_length=2, choices=NACIONAL_CHOICES, blank=True, null=True)
    nombreTutor = models.CharField(max_length=40, blank=True, null=True)
    apoyoEconomico = models.DecimalField(max_digits=10, decimal_places=2, db_column='apoyoEconomico', blank=True, null=True)
    modalidad = models.CharField(max_length=10, choices=MODALIDAD_CHOICES, blank=True, null=True)
    nombreEmpresa = models.CharField(max_length=255, blank=True, null=True)
    empresa = models.ForeignKey(Empresas, on_delete=models.CASCADE, db_column='empresa_id')
    programa_id = models.ForeignKey('Programas', on_delete=models.SET_NULL, null=True, blank=True, db_column='programa_id')
    Ofrece_apoyo = models.CharField(max_length=100, blank=True, null=True, db_column='Ofrece_apoyo')
    
    # Campos nuevos agregados en migración 0003
    # Comentados temporalmente porque no existen en la BD actual
    # tipo_oferta = models.CharField(max_length=20, choices=TIPO_OFERTA_CHOICES, blank=True, null=True)
    # apoyo_economico = models.BooleanField(default=False)  # Cambiado a BooleanField en migración 0004
    # nombre_responsable = models.CharField(max_length=255, blank=True, null=True)
    
    # Campos adicionales para descripción y fechas
    # descripcion = models.TextField(blank=True, null=True)
    # fecha_inicio = models.DateField(blank=True, null=True)
    # fecha_fin = models.DateField(blank=True, null=True)

    class Meta:
        db_table = 'ofertasempresas'


class EstadoProceso(models.Model):
    estado_id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=100)

    class Meta:
        db_table = 'estados_proceso'


class ProcesoCoformacion(models.Model):
    proceso_id = models.AutoField(primary_key=True)
    estudiante = models.ForeignKey('Estudiantes', on_delete=models.CASCADE)
    empresa = models.ForeignKey('Empresas', on_delete=models.CASCADE)
    oferta = models.ForeignKey('OfertasEmpresas', on_delete=models.CASCADE)
    fecha_inicio = models.DateField()
    fecha_fin = models.DateField(null=True, blank=True)
    estado = models.ForeignKey(EstadoProceso, on_delete=models.SET_NULL, null=True)
    observaciones = models.TextField(null=True, blank=True)

    class Meta:
        db_table = 'proceso_coformacion'


class DocumentosProceso(models.Model):
    documento_id = models.AutoField(primary_key=True)
    proceso = models.ForeignKey(ProcesoCoformacion, on_delete=models.CASCADE)
    nombre = models.CharField(max_length=255)
    archivo = models.FileField(upload_to='documentos_proceso/')
    fecha_subida = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'documentos_proceso'


class TiposActividad(models.Model):
    tipo_id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=100)
    descripcion = models.TextField(blank=True, null=True)

    class Meta:
        db_table = 'tipos_actividad'


class CalendarioActividades(models.Model):
    actividad_id = models.AutoField(primary_key=True)
    proceso = models.ForeignKey('ProcesoCoformacion', on_delete=models.CASCADE)
    tipo_actividad = models.ForeignKey(TiposActividad, on_delete=models.SET_NULL, null=True)
    descripcion = models.TextField()
    fecha = models.DateField()
    hora_inicio = models.TimeField()
    hora_fin = models.TimeField()

    class Meta:
        db_table = 'calendario_actividades'


class PlantillasCorreo(models.Model):
    plantilla_id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=100)
    asunto = models.CharField(max_length=255)
    cuerpo = models.TextField()
    fecha_creacion = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'plantillas_correo'


class HistorialComunicaciones(models.Model):
    comunicacion_id = models.AutoField(primary_key=True)
    estudiante = models.ForeignKey('Estudiantes', on_delete=models.CASCADE)
    plantilla = models.ForeignKey(PlantillasCorreo, on_delete=models.SET_NULL, null=True)
    fecha_envio = models.DateTimeField(auto_now_add=True)
    enviado_por = models.CharField(max_length=100)

    class Meta:
        db_table = 'historial_comunicaciones'

