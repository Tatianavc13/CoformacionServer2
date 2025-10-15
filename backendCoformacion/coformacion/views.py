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


class TiposContactoViewSet(viewsets.ModelViewSet):
    queryset = TiposContacto.objects.all()
    serializer_class = TiposContactoSerializer


class ContactosEmpresaViewSet(viewsets.ModelViewSet):
    queryset = ContactosEmpresa.objects.all()
    serializer_class = ContactosEmpresaSerializer


class OfertasEmpresasViewSet(viewsets.ModelViewSet):
    queryset = OfertasEmpresas.objects.all()
    serializer_class = OfertasEmpresasSerializer


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
