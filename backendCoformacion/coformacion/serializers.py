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
    class Meta:
        model = Empresas
        fields = '__all__'


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
        fields = '__all__'
        extra_fields = ['empresa_nombre', 'programa_nombre']

    def to_internal_value(self, data):
        print(f"DATOS RECIBIDOS: {data}")
        
        # Hacer una copia para no modificar los datos originales
        data = data.copy() if hasattr(data, 'copy') else dict(data)
        
        # Convertir "Si"/"No" a boolean antes de la validación
        if 'apoyo_economico' in data:
            print(f"APOYO ECONOMICO ORIGINAL: {data['apoyo_economico']}")
            if data['apoyo_economico'] == 'Si':
                data['apoyo_economico'] = True
            elif data['apoyo_economico'] == 'No':
                data['apoyo_economico'] = False
            print(f"APOYO ECONOMICO CONVERTIDO: {data['apoyo_economico']}")
        
        print(f"DATOS ANTES DE VALIDACION: {data}")
        
        try:
            result = super().to_internal_value(data)
            print(f"VALIDACION EXITOSA: {result}")
            return result
        except Exception as e:
            print(f"ERROR EN VALIDACION: {e}")
            raise

    def to_representation(self, instance):
        # Convertir boolean a "Si"/"No" para la respuesta
        data = super().to_representation(instance)
        if 'apoyo_economico' in data:
            data['apoyo_economico'] = 'Si' if instance.apoyo_economico else 'No'
        return data

