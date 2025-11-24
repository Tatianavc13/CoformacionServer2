from rest_framework import serializers
from .models import *

class RolesSerializer(serializers.ModelSerializer):
    class Meta:
        model = Roles
        fields = '__all__'


class PermisosSerializer(serializers.ModelSerializer):
    class Meta:
        model = Permisos
        fields = '__all__'


class RolesPermisosSerializer(serializers.ModelSerializer):
    class Meta:
        model = RolesPermisos
        fields = '__all__'

class TiposDocumentoSerializer(serializers.ModelSerializer):
    class Meta:
        model = TiposDocumento
        fields = '__all__'


class FacultadesSerializer(serializers.ModelSerializer):
    class Meta:
        model = Facultades
        fields = '__all__'


class ProgramasSerializer(serializers.ModelSerializer):
    class Meta:
        model = Programas
        fields = '__all__'


class MateriasNucleoSerializer(serializers.ModelSerializer):
    class Meta:
        model = MateriasNucleo
        fields = '__all__'


class ObjetivosAprendizajeSerializer(serializers.ModelSerializer):
    class Meta:
        model = ObjetivosAprendizaje
        fields = '__all__'

class PromocionesSerializer(serializers.ModelSerializer):
    class Meta:
        model = Promociones
        fields = '__all__'


class NivelesInglesSerializer(serializers.ModelSerializer):
    class Meta:
        model = NivelesIngles
        fields = '__all__'


class EstadosCarteraSerializer(serializers.ModelSerializer):
    class Meta:
        model = EstadosCartera
        fields = '__all__'


class EstudiantesSerializer(serializers.ModelSerializer):
    class Meta:
        model = Estudiantes
        fields = '__all__'


class SectoresEconomicosSerializer(serializers.ModelSerializer):
    class Meta:
        model = SectoresEconomicos
        fields = '__all__'


class TamanosEmpresaSerializer(serializers.ModelSerializer):
    class Meta:
        model = TamanosEmpresa
        fields = '__all__'


class EmpresasSerializer(serializers.ModelSerializer):
    nombre_persona_contacto_empresa = serializers.CharField(required=False, allow_blank=True)
    cargo_persona_contacto_empresa = serializers.CharField(required=False, allow_blank=True)
    numero_persona_contacto_empresa = serializers.CharField(required=False, allow_blank=True, allow_null=True)
    email_empresa = serializers.CharField(required=False, allow_blank=True, allow_null=True)
    ciudad_duplicada = serializers.CharField(required=False, allow_blank=True)
    
    class Meta:
        model = Empresas
        fields = '__all__'
        depth = 0  # Solo devolver IDs de ForeignKeys, no objetos anidados
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # Remover logo_url de los fields si existe (ya que está comentado en el modelo)
        if 'logo_url' in self.fields:
            self.fields.pop('logo_url')
    
    def to_internal_value(self, data):
        """
        Interceptar los datos antes de la validación para debugging
        """
        print(f"EmpresasSerializer - Datos recibidos: {data}")
        try:
            result = super().to_internal_value(data)
            print(f"EmpresasSerializer - Datos validados: {result}")
            return result
        except Exception as e:
            print(f"EmpresasSerializer - Error en validación: {e}")
            raise
    
    def create(self, validated_data):
        """
        Crear una empresa mapeando correctamente los campos a los nombres de columna de la BD
        """
        try:
            # Limpiar valores vacíos que podrían causar problemas
            for key, value in list(validated_data.items()):
                if isinstance(value, str) and value.strip() == '':
                    # Si es un campo opcional, establecerlo como None
                    try:
                        field = self.Meta.model._meta.get_field(key)
                        if field.null or field.blank:
                            validated_data[key] = None if field.null else ''
                    except:
                        pass
            
            # Asegurar que actividad_economica no esté vacío
            if 'actividad_economica' in validated_data and (not validated_data['actividad_economica'] or validated_data['actividad_economica'].strip() == ''):
                validated_data['actividad_economica'] = 'No especificada'
            
            # Asignar el valor de ciudad también a ciudad_duplicada (columna 'ciudad' en BD)
            if 'ciudad' in validated_data and validated_data['ciudad']:
                validated_data['ciudad_duplicada'] = validated_data['ciudad']
            elif 'ciudad_duplicada' not in validated_data:
                validated_data['ciudad_duplicada'] = validated_data.get('ciudad', 'No especificada')
            
            # Asignar valores por defecto a campos requeridos de contacto si no se proporcionan
            if 'nombre_persona_contacto_empresa' not in validated_data or not validated_data.get('nombre_persona_contacto_empresa'):
                validated_data['nombre_persona_contacto_empresa'] = 'No especificado'
            
            if 'cargo_persona_contacto_empresa' not in validated_data or not validated_data.get('cargo_persona_contacto_empresa'):
                validated_data['cargo_persona_contacto_empresa'] = 'No especificado'
            
            # Asegurar que numero_persona_contacto_empresa sea None si está vacío (es opcional)
            if 'numero_persona_contacto_empresa' in validated_data and (not validated_data['numero_persona_contacto_empresa'] or validated_data['numero_persona_contacto_empresa'].strip() == ''):
                validated_data['numero_persona_contacto_empresa'] = None
            
            # Asegurar que email_empresa sea None si está vacío (es opcional)
            if 'email_empresa' in validated_data and (not validated_data['email_empresa'] or validated_data['email_empresa'].strip() == ''):
                validated_data['email_empresa'] = None
            
            empresa = Empresas.objects.create(**validated_data)
            return empresa
        except Exception as e:
            import traceback
            error_details = traceback.format_exc()
            print(f"Error al crear empresa: {e}")
            print(f"Error completo:\n{error_details}")
            print(f"Datos recibidos: {validated_data}")
            raise serializers.ValidationError({
                'error': f'Error al crear la empresa: {str(e)}',
                'details': str(e)
            })


class TiposContactoSerializer(serializers.ModelSerializer):
    class Meta:
        model = TiposContacto
        fields = '__all__'


class ContactosEmpresaSerializer(serializers.ModelSerializer):
    class Meta:
        model = ContactosEmpresa
        fields = '__all__'


class EstadoProcesoSerializer(serializers.ModelSerializer):
    class Meta:
        model = EstadoProceso
        fields = '__all__'


class ProcesoCoformacionSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProcesoCoformacion
        fields = '__all__'


class DocumentosProcesoSerializer(serializers.ModelSerializer):
    class Meta:
        model = DocumentosProceso
        fields = '__all__'


class TiposActividadSerializer(serializers.ModelSerializer):
    class Meta:
        model = TiposActividad
        fields = '__all__'


class CalendarioActividadesSerializer(serializers.ModelSerializer):
    class Meta:
        model = CalendarioActividades
        fields = '__all__'


class PlantillasCorreoSerializer(serializers.ModelSerializer):
    class Meta:
        model = PlantillasCorreo
        fields = '__all__'


class HistorialComunicacionesSerializer(serializers.ModelSerializer):
    class Meta:
        model = HistorialComunicaciones
        fields = '__all__'


class CoformacionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Coformacion
        fields = '__all__'


class EmpresaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Empresas
        fields = '__all__'


class EstudianteSerializer(serializers.ModelSerializer):
    empresa = EmpresaSerializer(source='empresa_id', read_only=True)
    
    class Meta:
        model = Estudiantes
        fields = '__all__'

class OfertasEmpresasSerializer(serializers.ModelSerializer):
    empresa_nombre = serializers.CharField(source='empresa.nombre_comercial', read_only=True)
    programa_nombre = serializers.CharField(source='programa_id.nombre', read_only=True)

    class Meta:
        model = OfertasEmpresas
        # Usar fields en lugar de exclude para tener control total
        fields = ['idOferta', 'nacional', 'nombreTutor', 'apoyoEconomico', 
                 'modalidad', 'nombreEmpresa', 'empresa', 'programa_id',
                 'empresa_nombre', 'programa_nombre']
        extra_fields = ['empresa_nombre', 'programa_nombre']
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        
        # SIEMPRE excluir tipo_oferta y otros campos que no existen en la BD
        campos_a_excluir = ['tipo_oferta', 'apoyo_economico', 'nombre_responsable', 'descripcion', 'fecha_inicio', 'fecha_fin']
        for campo in campos_a_excluir:
            if campo in self.fields:
                self.fields.pop(campo)
                print(f"✓ Campo '{campo}' excluido del serializer")
        
        # Verificar qué campos existen en la base de datos
        try:
            from django.db import connection
            with connection.cursor() as cursor:
                cursor.execute("SHOW COLUMNS FROM ofertasempresas")
                existing_columns = [row[0] for row in cursor.fetchall()]
            
            # Excluir cualquier campo que no exista en la BD
            campos_para_remover = []
            for campo in self.fields.keys():
                # Mantener campos especiales como empresa_nombre, programa_nombre (read_only)
                if campo in ['empresa_nombre', 'programa_nombre']:
                    continue
                # Si el campo no existe en la BD y no es un campo especial, excluirlo
                if campo not in existing_columns and campo not in ['idOferta']:
                    campos_para_remover.append(campo)
            
            for campo in campos_para_remover:
                if campo in self.fields:
                    self.fields.pop(campo)
                    print(f"Campo '{campo}' removido del serializer porque no existe en la base de datos")
        except Exception as e:
            # Si hay error al verificar, continuar con todos los campos
            print(f"Advertencia: No se pudo verificar columnas de la base de datos: {e}")

    def to_internal_value(self, data):
        print(f"DATOS RECIBIDOS EN SERIALIZER: {data}")
        
        # Hacer una copia para no modificar los datos originales
        data = data.copy() if hasattr(data, 'copy') else dict(data)
        
        # Asegurar que empresa esté presente (puede venir como empresa o empresa_id)
        if 'empresa' not in data or not data.get('empresa'):
            if 'empresa_id' in data and data.get('empresa_id'):
                data['empresa'] = data['empresa_id']
                print(f"✓ empresa_id mapeado a empresa: {data['empresa']}")
            else:
                print(f"⚠ ADVERTENCIA: No se encontró empresa ni empresa_id en los datos")
        
        # Mapear tipo_oferta a nacional antes de la validación
        # tipo_oferta: 'Nacional' -> nacional: 'Si'
        # tipo_oferta: 'Internacional' -> nacional: 'No'
        if 'tipo_oferta' in data:
            tipo_oferta = data.get('tipo_oferta', 'Nacional')
            if tipo_oferta == 'Nacional':
                data['nacional'] = 'Si'
            elif tipo_oferta == 'Internacional':
                data['nacional'] = 'No'
            else:
                data['nacional'] = 'No'  # Por defecto
            # Remover tipo_oferta ya que no existe en la BD
            del data['tipo_oferta']
        
        # Convertir "Si"/"No" a boolean para apoyo_economico (que es BooleanField)
        # Solo si el campo existe en la BD
        if 'apoyo_economico' in data and data['apoyo_economico'] is not None:
            print(f"APOYO ECONOMICO ORIGINAL: {data['apoyo_economico']}")
            if isinstance(data['apoyo_economico'], str):
                if data['apoyo_economico'].lower() == 'si' or data['apoyo_economico'] == 'Si':
                    data['apoyo_economico'] = True
                elif data['apoyo_economico'].lower() == 'no' or data['apoyo_economico'] == 'No':
                    data['apoyo_economico'] = False
            print(f"APOYO ECONOMICO CONVERTIDO: {data['apoyo_economico']}")
        elif 'apoyo_economico' not in data:
            # Si no se envía, usar False por defecto (solo si el campo existe en la BD)
            pass  # No agregar si no existe en la BD
        
        # Asegurar que empresa sea un entero si viene como string
        if 'empresa' in data and isinstance(data['empresa'], str):
            try:
                data['empresa'] = int(data['empresa'])
            except (ValueError, TypeError):
                pass
        
        # Asegurar que programa_id sea un entero si viene como string
        if 'programa_id' in data and data['programa_id'] is not None:
            if isinstance(data['programa_id'], str):
                try:
                    data['programa_id'] = int(data['programa_id'])
                except (ValueError, TypeError):
                    pass
        
        print(f"DATOS ANTES DE VALIDACION: {data}")
        
        try:
            result = super().to_internal_value(data)
            print(f"VALIDACION EXITOSA: {result}")
            return result
        except Exception as e:
            import traceback
            error_trace = traceback.format_exc()
            print(f"ERROR EN VALIDACION: {e}")
            print(error_trace)
            raise serializers.ValidationError(f"Error de validación: {str(e)}")

    def create(self, validated_data):
        """
        Crear una oferta mapeando correctamente los campos a los nombres de columna de la BD
        Estructura real de la tabla ofertasempresas:
        - idOferta (PK, auto)
        - nacional (enum: 'No','Si')
        - nombreTutor (varchar 40)
        - apoyoEconomico (decimal 10,2)
        - modalidad (enum: 'Presencial','Virtual','Híbrido')
        - nombreEmpresa (varchar 255)
        - empresa_id (FK)
        - programa_id (FK, nullable)
        """
        # Columnas que realmente existen en la BD
        columnas_reales = [
            'idOferta', 'nacional', 'nombreTutor', 'apoyoEconomico', 
            'modalidad', 'nombreEmpresa', 'empresa_id', 'programa_id'
        ]
        
        # Crear diccionario con los nombres de columna correctos
        data_para_crear = {}
        
        # Mapear campos del frontend a columnas de la BD
        # nacional ya está mapeado en to_internal_value
        if 'nacional' in validated_data:
            data_para_crear['nacional'] = validated_data['nacional']
        
        # nombre_responsable -> nombreTutor
        if 'nombre_responsable' in validated_data:
            data_para_crear['nombreTutor'] = validated_data['nombre_responsable'][:40]  # Limitar a 40 caracteres
        elif 'nombreTutor' in validated_data:
            data_para_crear['nombreTutor'] = validated_data['nombreTutor'][:40]
        
        # apoyo_economico -> apoyoEconomico (convertir "Si"/"No" a decimal)
        if 'apoyo_economico' in validated_data:
            apoyo = validated_data['apoyo_economico']
            if isinstance(apoyo, bool):
                # Si es boolean, usar 0 o un valor por defecto
                data_para_crear['apoyoEconomico'] = 0.00
            elif isinstance(apoyo, str):
                # Si es "Si", usar un valor por defecto, si es "No", usar 0
                data_para_crear['apoyoEconomico'] = 0.00 if apoyo.lower() == 'no' else 0.00
            else:
                data_para_crear['apoyoEconomico'] = float(apoyo) if apoyo else 0.00
        elif 'apoyoEconomico' in validated_data:
            data_para_crear['apoyoEconomico'] = validated_data['apoyoEconomico']
        else:
            data_para_crear['apoyoEconomico'] = 0.00
        
        # modalidad
        if 'modalidad' in validated_data:
            data_para_crear['modalidad'] = validated_data['modalidad']
        
        # nombreEmpresa
        if 'nombreEmpresa' in validated_data:
            data_para_crear['nombreEmpresa'] = validated_data['nombreEmpresa']
        
        # empresa (ForeignKey - REQUERIDO, Django espera el objeto, no el ID)
        empresa_obj = None
        empresa_value = validated_data.get('empresa') or validated_data.get('empresa_id')
        
        print(f"Intentando obtener empresa. Valor recibido: {empresa_value}, Tipo: {type(empresa_value)}")
        
        if empresa_value:
            # Si es un objeto, usarlo directamente
            if hasattr(empresa_value, 'empresa_id') or hasattr(empresa_value, 'pk'):
                empresa_obj = empresa_value
                print(f"✓ Empresa es un objeto: {empresa_obj}")
            else:
                # Si es un número, obtener el objeto
                from .models import Empresas
                try:
                    empresa_id = int(empresa_value)
                    print(f"Buscando empresa con ID: {empresa_id}")
                    empresa_obj = Empresas.objects.get(pk=empresa_id)
                    print(f"✓ Empresa obtenida correctamente: ID {empresa_id}, Nombre: {empresa_obj.nombre_comercial or empresa_obj.razon_social}")
                except Empresas.DoesNotExist:
                    print(f"ERROR: No se encontró empresa con ID {empresa_value}")
                    raise serializers.ValidationError({
                        'empresa': f'No se encontró una empresa con ID {empresa_value}'
                    })
                except (ValueError, TypeError) as e:
                    print(f"ERROR: Valor inválido para empresa: {empresa_value}, Error: {e}")
                    raise serializers.ValidationError({
                        'empresa': f'El ID de empresa debe ser un número válido. Valor recibido: {empresa_value}'
                    })
        else:
            print(f"ERROR: No se recibió valor para empresa. validated_data keys: {list(validated_data.keys())}")
            raise serializers.ValidationError({
                'empresa': 'El campo empresa es requerido. Debe proporcionar un ID de empresa válido.'
            })
        
        data_para_crear['empresa'] = empresa_obj
        print(f"✓ Empresa asignada correctamente al diccionario de creación")
        
        # programa_id (ForeignKey - puede ser None)
        if 'programa_id' in validated_data:
            programa_value = validated_data['programa_id']
            if programa_value is not None and programa_value != '':
                # Si es un objeto, usarlo directamente
                if hasattr(programa_value, 'programa_id') or hasattr(programa_value, 'pk'):
                    data_para_crear['programa_id'] = programa_value
                else:
                    # Si es un número, obtener el objeto
                    from .models import Programas
                    try:
                        data_para_crear['programa_id'] = Programas.objects.get(pk=int(programa_value))
                    except (Programas.DoesNotExist, ValueError, TypeError) as e:
                        print(f"Error obteniendo programa con ID {programa_value}: {e}")
                        data_para_crear['programa_id'] = None
            else:
                data_para_crear['programa_id'] = None
        
        # Asegurar que todos los campos requeridos tengan valores
        if 'nacional' not in data_para_crear or not data_para_crear.get('nacional'):
            data_para_crear['nacional'] = 'No'
        if 'nombreTutor' not in data_para_crear or not data_para_crear.get('nombreTutor'):
            data_para_crear['nombreTutor'] = 'Sin especificar'
        if 'apoyoEconomico' not in data_para_crear or data_para_crear.get('apoyoEconomico') is None:
            data_para_crear['apoyoEconomico'] = 0.00
        if 'modalidad' not in data_para_crear or not data_para_crear.get('modalidad'):
            data_para_crear['modalidad'] = 'Presencial'
        if 'nombreEmpresa' not in data_para_crear or not data_para_crear.get('nombreEmpresa'):
            # Intentar obtener el nombre de la empresa si tenemos el objeto
            if 'empresa' in data_para_crear and data_para_crear['empresa']:
                try:
                    empresa = data_para_crear['empresa']
                    if hasattr(empresa, 'nombre_comercial') and empresa.nombre_comercial:
                        data_para_crear['nombreEmpresa'] = empresa.nombre_comercial
                    elif hasattr(empresa, 'razon_social') and empresa.razon_social:
                        data_para_crear['nombreEmpresa'] = empresa.razon_social
                    else:
                        data_para_crear['nombreEmpresa'] = 'Sin especificar'
                except:
                    data_para_crear['nombreEmpresa'] = 'Sin especificar'
            else:
                data_para_crear['nombreEmpresa'] = 'Sin especificar'
        
        # Verificación final: asegurar que empresa esté presente
        if 'empresa' not in data_para_crear or data_para_crear.get('empresa') is None:
            raise serializers.ValidationError({
                'empresa': 'El campo empresa es requerido'
            })
        
        # Verificación final: asegurar que tipo_oferta NO esté presente
        if 'tipo_oferta' in data_para_crear:
            print(f"⚠ ERROR CRÍTICO: tipo_oferta encontrado en data_para_crear, removiéndolo...")
            del data_para_crear['tipo_oferta']
        
        # También remover cualquier otro campo que no exista en la BD
        campos_permitidos = ['nacional', 'nombreTutor', 'apoyoEconomico', 'modalidad', 'nombreEmpresa', 'empresa', 'programa_id']
        campos_finales = {}
        for campo, valor in data_para_crear.items():
            if campo in campos_permitidos:
                campos_finales[campo] = valor
            else:
                print(f"⚠ EXCLUYENDO campo '{campo}' de la creación (no permitido)")
        
        print(f"Creando oferta con campos: {list(campos_finales.keys())}")
        print(f"Valores: {campos_finales}")
        
        try:
            # Usar el manager directamente con solo los campos permitidos
            oferta = OfertasEmpresas.objects.create(**campos_finales)
            return oferta
        except Exception as e:
            import traceback
            error_trace = traceback.format_exc()
            print(f"Error al crear oferta: {e}")
            print(f"Error completo:\n{error_trace}")
            print(f"Datos que se intentaron crear: {data_para_crear}")
            raise serializers.ValidationError({
                'error': f'Error al crear la oferta: {str(e)}',
                'details': str(e)
            })

    def to_representation(self, instance):
        # Convertir boolean a "Si"/"No" para la respuesta
        data = super().to_representation(instance)
        if 'apoyo_economico' in data:
            data['apoyo_economico'] = 'Si' if instance.apoyo_economico else 'No'
        return data

