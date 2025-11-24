from rest_framework import viewsets, status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import Coformacion, Estudiantes, Empresas, Roles, Permisos, RolesPermisos, TiposDocumento, Facultades, Programas, MateriasNucleo, ObjetivosAprendizaje, Promociones, NivelesIngles, EstadosCartera, SectoresEconomicos, TamanosEmpresa, TiposContacto, ContactosEmpresa, OfertasEmpresas, EstadoProceso, ProcesoCoformacion, DocumentosProceso, TiposActividad, CalendarioActividades, PlantillasCorreo, HistorialComunicaciones
from .serializers import OfertasEmpresasSerializer
from .serializers import *
from rest_framework import status
import google.generativeai as genai
import os

class RolesViewSet(viewsets.ModelViewSet):
    queryset = Roles.objects.all()
    serializer_class = RolesSerializer


class PermisosViewSet(viewsets.ModelViewSet):
    queryset = Permisos.objects.all()
    serializer_class = PermisosSerializer


class RolesPermisosViewSet(viewsets.ModelViewSet):
    queryset = RolesPermisos.objects.all()
    serializer_class = RolesPermisosSerializer

class TiposDocumentoViewSet(viewsets.ModelViewSet):
    queryset = TiposDocumento.objects.all()
    serializer_class = TiposDocumentoSerializer

class FacultadesViewSet(viewsets.ModelViewSet):
    queryset = Facultades.objects.all()
    serializer_class = FacultadesSerializer


class ProgramasViewSet(viewsets.ModelViewSet):
    queryset = Programas.objects.all()
    serializer_class = ProgramasSerializer


class MateriasNucleoViewSet(viewsets.ModelViewSet):
    queryset = MateriasNucleo.objects.all()
    serializer_class = MateriasNucleoSerializer


class ObjetivosAprendizajeViewSet(viewsets.ModelViewSet):
    queryset = ObjetivosAprendizaje.objects.all()
    serializer_class = ObjetivosAprendizajeSerializer


class PromocionesViewSet(viewsets.ModelViewSet):
    queryset = Promociones.objects.all()
    serializer_class = PromocionesSerializer


class NivelesInglesViewSet(viewsets.ModelViewSet):
    queryset = NivelesIngles.objects.all()
    serializer_class = NivelesInglesSerializer


class EstadosCarteraViewSet(viewsets.ModelViewSet):
    queryset = EstadosCartera.objects.all()
    serializer_class = EstadosCarteraSerializer


class EstudiantesViewSet(viewsets.ModelViewSet):
    queryset = Estudiantes.objects.all()
    serializer_class = EstudiantesSerializer


class SectoresEconomicosViewSet(viewsets.ModelViewSet):
    queryset = SectoresEconomicos.objects.all()
    serializer_class = SectoresEconomicosSerializer


class TamanosEmpresaViewSet(viewsets.ModelViewSet):
    queryset = TamanosEmpresa.objects.all()
    serializer_class = TamanosEmpresaSerializer


class EmpresasViewSet(viewsets.ModelViewSet):
    queryset = Empresas.objects.all()
    serializer_class = EmpresasSerializer
    
    def retrieve(self, request, *args, **kwargs):
        try:
            return super().retrieve(request, *args, **kwargs)
        except Exception as e:
            import traceback
            error_trace = traceback.format_exc()
            print(f"Error en EmpresasViewSet.retrieve: {e}")
            print(error_trace)
            return Response(
                {'error': f'Error al obtener la empresa: {str(e)}'},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )


class TiposContactoViewSet(viewsets.ModelViewSet):
    queryset = TiposContacto.objects.all()
    serializer_class = TiposContactoSerializer


class ContactosEmpresaViewSet(viewsets.ModelViewSet):
    queryset = ContactosEmpresa.objects.all()
    serializer_class = ContactosEmpresaSerializer


class OfertasEmpresasViewSet(viewsets.ModelViewSet):
    queryset = OfertasEmpresas.objects.all()
    serializer_class = OfertasEmpresasSerializer
    
    def perform_create(self, serializer):
        """
        Sobrescribir perform_create para asegurar que tipo_oferta nunca se intente guardar
        """
        # El serializer ya debería haber manejado el mapeo, pero verificamos una vez más
        validated_data = serializer.validated_data.copy()
        
        # Asegurar que tipo_oferta NO esté presente
        validated_data.pop('tipo_oferta', None)
        
        # Guardar usando el método create del serializer
        serializer.save()
    
    def create(self, request, *args, **kwargs):
        try:
            # Agregar valores por defecto para campos antiguos requeridos si no están presentes
            data = request.data.copy()
            
            print(f"Datos recibidos del frontend: {data}")
            
            # Verificar qué campos existen en la base de datos
            # Si las migraciones no se han ejecutado, solo usar campos básicos
            from django.db import connection
            with connection.cursor() as cursor:
                cursor.execute("SHOW COLUMNS FROM ofertasempresas")
                existing_columns = [row[0] for row in cursor.fetchall()]
            
            # Asegurar que empresa esté presente (puede venir como empresa_id o empresa)
            if 'empresa' not in data or not data.get('empresa'):
                # Intentar obtener desde empresa_id
                if 'empresa_id' in data and data.get('empresa_id'):
                    data['empresa'] = data['empresa_id']
                else:
                    error_message = 'El campo empresa es requerido'
                    print(f"ERROR: {error_message}. Datos recibidos: {data}")
                    return Response(
                        {'error': error_message},
                        status=status.HTTP_400_BAD_REQUEST
                    )
            
            # Si no se envía 'nacional', usar un valor por defecto
            if 'nacional' not in data or not data['nacional']:
                data['nacional'] = 'No'
            
            # Si no se envía 'nombreTutor', usar nombre_responsable o un valor por defecto
            if 'nombreTutor' not in data or not data['nombreTutor']:
                nombre_responsable = data.get('nombre_responsable', 'Sin especificar')
                data['nombreTutor'] = nombre_responsable[:40] if nombre_responsable else 'Sin especificar'
            # También mapear nombre_responsable a nombreTutor si viene del frontend
            if 'nombre_responsable' in data and 'nombreTutor' not in data:
                data['nombreTutor'] = data['nombre_responsable'][:40]
            
            # Si no se envía 'apoyoEconomico', usar 0
            if 'apoyoEconomico' not in data or data['apoyoEconomico'] is None:
                data['apoyoEconomico'] = 0.00
            # Mapear apoyo_economico a apoyoEconomico si viene del frontend
            if 'apoyo_economico' in data:
                apoyo = data['apoyo_economico']
                if isinstance(apoyo, str):
                    data['apoyoEconomico'] = 0.00 if apoyo.lower() == 'no' else 0.00
                elif isinstance(apoyo, bool):
                    data['apoyoEconomico'] = 0.00
                else:
                    data['apoyoEconomico'] = float(apoyo) if apoyo else 0.00
                # Remover apoyo_economico ya que usamos apoyoEconomico
                del data['apoyo_economico']
            
            # Si no se envía 'modalidad', usar un valor por defecto
            if 'modalidad' not in data or not data['modalidad']:
                data['modalidad'] = 'Presencial'
            
            # Si no se envía 'nombreEmpresa', obtenerlo de la empresa
            if 'nombreEmpresa' not in data or not data.get('nombreEmpresa'):
                try:
                    empresa_id = data.get('empresa')
                    if empresa_id:
                        # Convertir a int si es necesario
                        if not isinstance(empresa_id, int):
                            empresa_id = int(empresa_id)
                        empresa = Empresas.objects.get(pk=empresa_id)
                        data['nombreEmpresa'] = empresa.nombre_comercial or empresa.razon_social or 'Sin especificar'
                    else:
                        data['nombreEmpresa'] = 'Sin especificar'
                except (Empresas.DoesNotExist, ValueError, TypeError) as e:
                    print(f"Error obteniendo nombre de empresa: {e}")
                    data['nombreEmpresa'] = 'Sin especificar'
            
            # PRIMERO: Mapear tipo_oferta a nacional (que es el campo que existe en la BD)
            # tipo_oferta: 'Nacional' -> nacional: 'Si'
            # tipo_oferta: 'Internacional' -> nacional: 'No'
            # Esto DEBE hacerse ANTES de cualquier otra operación
            if 'tipo_oferta' in data:
                tipo_oferta = data.get('tipo_oferta', 'Nacional')
                if tipo_oferta == 'Nacional':
                    data['nacional'] = 'Si'
                elif tipo_oferta == 'Internacional':
                    data['nacional'] = 'No'
                else:
                    data['nacional'] = 'No'  # Por defecto
                # Remover tipo_oferta inmediatamente para evitar que se intente insertar
                del data['tipo_oferta']
                print(f"✓ tipo_oferta '{tipo_oferta}' mapeado a nacional '{data['nacional']}' y removido de data")
            
            # Asegurar que nacional tenga un valor si no se proporcionó tipo_oferta
            if 'nacional' not in data or not data['nacional']:
                data['nacional'] = 'No'
            
            # Remover otros campos que no existen en la base de datos
            campos_para_remover = []
            campos_nuevos = ['apoyo_economico', 'nombre_responsable', 'descripcion', 'fecha_inicio', 'fecha_fin']
            for campo in campos_nuevos:
                if campo not in existing_columns and campo in data:
                    print(f"Advertencia: El campo '{campo}' no existe en la base de datos, se removerá de los datos")
                    campos_para_remover.append(campo)
            
            for campo in campos_para_remover:
                del data[campo]
            
            # Asegurar que tipo_oferta NO esté en los datos finales (verificación final)
            if 'tipo_oferta' in data:
                print(f"⚠ ADVERTENCIA CRÍTICA: tipo_oferta todavía está en data, removiéndolo...")
                del data['tipo_oferta']
            
            # Verificación final: asegurar que tipo_oferta no esté presente
            if 'tipo_oferta' in data:
                raise ValueError("ERROR: tipo_oferta no debe estar en data antes de serializar. Debe mapearse a 'nacional'.")
            
            print(f"Datos finales antes de serializar (sin tipo_oferta): {list(data.keys())}")
            
            serializer = self.get_serializer(data=data)
            serializer.is_valid(raise_exception=True)
            self.perform_create(serializer)
            headers = self.get_success_headers(serializer.data)
            return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)
        except Exception as e:
            import traceback
            error_trace = traceback.format_exc()
            print(f"Error en OfertasEmpresasViewSet.create: {e}")
            print(error_trace)
            # Retornar solo el mensaje de error sin el traceback completo para el cliente
            error_message = str(e)
            if hasattr(e, 'detail'):
                error_message = str(e.detail)
            return Response(
                {'error': f'Error al crear la oferta: {error_message}'},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )


class EstadoProcesoViewSet(viewsets.ModelViewSet):
    queryset = EstadoProceso.objects.all()
    serializer_class = EstadoProcesoSerializer


class ProcesoCoformacionViewSet(viewsets.ModelViewSet):
    queryset = ProcesoCoformacion.objects.all()
    serializer_class = ProcesoCoformacionSerializer


class DocumentosProcesoViewSet(viewsets.ModelViewSet):
    queryset = DocumentosProceso.objects.all()
    serializer_class = DocumentosProcesoSerializer


class TiposActividadViewSet(viewsets.ModelViewSet):
    queryset = TiposActividad.objects.all()
    serializer_class = TiposActividadSerializer


class CalendarioActividadesViewSet(viewsets.ModelViewSet):
    queryset = CalendarioActividades.objects.all()
    serializer_class = CalendarioActividadesSerializer


class PlantillasCorreoViewSet(viewsets.ModelViewSet):
    queryset = PlantillasCorreo.objects.all()
    serializer_class = PlantillasCorreoSerializer


class HistorialComunicacionesViewSet(viewsets.ModelViewSet):
    queryset = HistorialComunicaciones.objects.all()
    serializer_class = HistorialComunicacionesSerializer


class CoformacionViewSet(viewsets.ModelViewSet):
    queryset = Coformacion.objects.all()
    serializer_class = CoformacionSerializer

genai.configure(api_key=os.getenv("AIzaSyDlrQj_C8iSkOwdRli8aJxQGH7I898TuXM"))

@api_view(['POST'])
def login_universal(request):
    """
    Endpoint universal para autenticar estudiantes, empresas y usuarios de coformación
    """
    # Normalizar entradas
    nombre_completo = request.data.get('nombre_completo')
    numero_documento = request.data.get('numero_documento')
    tipo_usuario = request.data.get('tipo_usuario')  # Puede venir o no

    if isinstance(nombre_completo, str):
        nombre_completo = nombre_completo.strip()
    if isinstance(numero_documento, str):
        numero_documento = numero_documento.strip()

    if not nombre_completo or not numero_documento:
        return Response(
            {'error': 'Se requieren nombre completo y número de documento'},
            status=status.HTTP_400_BAD_REQUEST
        )

    try:
        # Si se especifica tipo_usuario, usar la lógica anterior (compatibilidad)
        if tipo_usuario == 'coformacion':
            usuario = Coformacion.objects.get(
                nombre_completo__icontains=nombre_completo,
                identificacion=numero_documento
            )
            serializer = CoformacionSerializer(usuario)
            redirect_to = '/coformacion'
            tipo_detectado = 'coformacion'
        elif tipo_usuario == 'estudiante':
            usuario = Estudiantes.objects.get(
                nombre_completo__icontains=nombre_completo,
                numero_documento=numero_documento
            )
            serializer = EstudiantesSerializer(usuario)
            redirect_to = '/perfil-estudiante'
            tipo_detectado = 'estudiante'
        elif tipo_usuario == 'empresa':
            # Intentar por nombre_comercial o razon_social
            from django.db.models import Q
            usuario = Empresas.objects.get(
                Q(nombre_comercial__icontains=nombre_completo) | Q(razon_social__icontains=nombre_completo),
                nit=numero_documento
            )
            serializer = EmpresasSerializer(usuario)
            redirect_to = '/home-empresa'
            tipo_detectado = 'empresa'
        else:
            # Lógica universal: probar coformacion, luego estudiante, luego empresa
            try:
                usuario = Coformacion.objects.get(
                    nombre_completo__icontains=nombre_completo,
                    identificacion=numero_documento
                )
                serializer = CoformacionSerializer(usuario)
                redirect_to = '/coformacion'
                tipo_detectado = 'coformacion'
            except Coformacion.DoesNotExist:
                try:
                    usuario = Estudiantes.objects.get(
                        nombre_completo__icontains=nombre_completo,
                        numero_documento=numero_documento
                    )
                    serializer = EstudiantesSerializer(usuario)
                    redirect_to = '/perfil-estudiante'
                    tipo_detectado = 'estudiante'
                except Estudiantes.DoesNotExist:
                    try:
                        from django.db.models import Q
                        usuario = Empresas.objects.get(
                            Q(nombre_comercial__icontains=nombre_completo) | Q(razon_social__icontains=nombre_completo),
                            nit=numero_documento
                        )
                        serializer = EmpresasSerializer(usuario)
                        redirect_to = '/home-empresa'
                        tipo_detectado = 'empresa'
                    except Empresas.DoesNotExist:
                        # Información mínima para diagnóstico en desarrollo (sin exponer datos sensibles)
                        return Response(
                            {
                                'error': 'Credenciales incorrectas. Verifique sus datos.',
                                'detalle': {
                                    'nombre_completo': nombre_completo,
                                    'numero_documento': numero_documento
                                }
                            },
                            status=status.HTTP_401_UNAUTHORIZED
                        )

        return Response({
            'success': True,
            'message': f'Login exitoso como {tipo_detectado}',
            'data': serializer.data,
            'tipo_usuario': tipo_detectado,
            'redirect_to': redirect_to
        }, status=status.HTTP_200_OK)

    except Exception as e:
        return Response(
            {'error': f'Error interno del servidor: {str(e)}'},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )

# Mantener el endpoint específico de estudiantes por compatibilidad
@api_view(['POST'])
def login_estudiante(request):
    """
    Endpoint específico para autenticar estudiantes (mantenido por compatibilidad)
    """
    request.data['tipo_usuario'] = 'estudiante'
    return login_universal(request)

@api_view(['POST'])
def recomendar_ofertas(request):
    estudiante = request.data.get("estudiante")
    ofertas = request.data.get("ofertas")

    if not estudiante or not ofertas:
        return Response({"error": "Faltan datos"}, status=status.HTTP_400_BAD_REQUEST)

    prompt = f"""
    Eres un sistema de recomendación para un estudiante.
    El estudiante tiene este perfil: {estudiante}
    Estas son las ofertas disponibles: {ofertas}
    Devuélveme un JSON con las 3 ofertas más relevantes explicando brevemente por qué.
    """

    try:
        model = genai.GenerativeModel("gemini-1.5-flash")
        response = model.generate_content(prompt)
        return Response({"recomendaciones": response.text})
    except Exception as e:
        return Response({"error": str(e)}, status=500)

@api_view(['GET'])
def recomendaciones_por_estudiante(request, estudiante_id):
    """
    Obtiene recomendaciones de ofertas para todos los estudiantes del mismo programa
    que el estudiante especificado, mostrando qué estudiantes son compatibles con cada oferta.
    """
    try:
        # Obtener el estudiante de referencia para conocer su programa
        estudiante_referencia = Estudiantes.objects.get(pk=estudiante_id)

        # Buscar todas las ofertas que coincidan con el programa del estudiante de referencia
        ofertas = OfertasEmpresas.objects.filter(programa_id=estudiante_referencia.programa_id)

        # Buscar todos los estudiantes del mismo programa que están disponibles
        estudiantes_programa = Estudiantes.objects.filter(
            programa_id=estudiante_referencia.programa_id,
            estado='Activo'  # Solo estudiantes activos
        )

        # Crear lista de recomendaciones
        recomendaciones = []

        for oferta in ofertas:
            # Serializar la oferta
            serializer = OfertasEmpresasSerializer(oferta)
            oferta_data = serializer.data

            # Encontrar estudiantes compatibles para esta oferta
            # (por ahora todos los del mismo programa, pero aquí se puede agregar más lógica de matching)
            estudiantes_compatibles = estudiantes_programa

            # Si hay estudiantes compatibles, crear una recomendación por cada uno
            if estudiantes_compatibles.exists():
                # Para mostrar variedad, podemos rotar entre estudiantes o usar algún criterio
                # Por ahora, asignaremos el primer estudiante disponible pero rotando
                index = oferta.idOferta % estudiantes_compatibles.count()
                estudiante_asignado = estudiantes_compatibles[index]

                oferta_data["estudiante"] = estudiante_asignado.nombre_completo
                oferta_data["estudiante_id"] = estudiante_asignado.estudiante_id
                recomendaciones.append(oferta_data)
            else:
                # Si no hay estudiantes compatibles, mostrar sin asignar
                oferta_data["estudiante"] = "Sin asignar"
                oferta_data["estudiante_id"] = None
                recomendaciones.append(oferta_data)

        return Response(recomendaciones)

    except Estudiantes.DoesNotExist:
        return Response({'error': 'Estudiante no encontrado'}, status=404)

@api_view(['GET'])
def recomendaciones_completas(request):
    """
    Obtiene todas las ofertas disponibles y muestra estudiantes compatibles para cada una.
    Este endpoint es útil para ver el panorama completo de ofertas y estudiantes.
    """
    try:
        # Obtener todas las ofertas activas
        ofertas = OfertasEmpresas.objects.all()

        # Obtener todos los estudiantes activos
        estudiantes_activos = Estudiantes.objects.filter(estado='Activo')

        recomendaciones_completas = []

        for oferta in ofertas:
            # Serializar la oferta
            serializer = OfertasEmpresasSerializer(oferta)
            oferta_data = serializer.data

            # Encontrar estudiantes compatibles para esta oferta
            estudiantes_compatibles = estudiantes_activos.filter(
                programa_id=oferta.programa_id
            )

            if estudiantes_compatibles.exists():
                # Crear una recomendación para cada estudiante compatible
                for i, estudiante in enumerate(estudiantes_compatibles):
                    oferta_recomendacion = oferta_data.copy()
                    oferta_recomendacion["estudiante"] = estudiante.nombre_completo
                    oferta_recomendacion["estudiante_id"] = estudiante.estudiante_id
                    oferta_recomendacion["es_principal"] = i == 0  # Marcar el primer estudiante como principal
                    recomendaciones_completas.append(oferta_recomendacion)
            else:
                # Si no hay estudiantes compatibles, mostrar sin asignar
                oferta_data["estudiante"] = "Sin estudiantes compatibles"
                oferta_data["estudiante_id"] = None
                oferta_data["es_principal"] = True
                recomendaciones_completas.append(oferta_data)

        return Response({
            'total_ofertas': ofertas.count(),
            'total_estudiantes_activos': estudiantes_activos.count(),
            'recomendaciones': recomendaciones_completas
        })

    except Exception as e:
        return Response({'error': f'Error interno: {str(e)}'}, status=500)
