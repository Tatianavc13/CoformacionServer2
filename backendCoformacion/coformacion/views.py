from rest_framework import viewsets, status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import serializers
from .models import Coformacion, Estudiantes, Empresas, Roles, Permisos, RolesPermisos, TiposDocumento, Facultades, Programas, MateriasNucleo, ObjetivosAprendizaje, Promociones, NivelesIngles, EstadosCartera, SectoresEconomicos, TamanosEmpresa, TiposContacto, ContactosEmpresa, OfertasEmpresas, EstadoProceso, ProcesoCoformacion, DocumentosProceso, TiposActividad, CalendarioActividades, PlantillasCorreo, HistorialComunicaciones
from .serializers import OfertasEmpresasSerializer
from .serializers import *
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


class EstudiantesEpsViewSet(viewsets.ModelViewSet):
    queryset = EstudiantesEps.objects.all()
    serializer_class = EstudiantesEpsSerializer


class SectoresEconomicosViewSet(viewsets.ModelViewSet):
    queryset = SectoresEconomicos.objects.all()
    serializer_class = SectoresEconomicosSerializer


class TamanosEmpresaViewSet(viewsets.ModelViewSet):
    queryset = TamanosEmpresa.objects.all()
    serializer_class = TamanosEmpresaSerializer


class EmpresasViewSet(viewsets.ModelViewSet):
    queryset = Empresas.objects.all()
    serializer_class = EmpresasSerializer

    def list(self, request, *args, **kwargs):
        try:
            return super().list(request, *args, **kwargs)
        except Exception as e:
            import traceback
            error_trace = traceback.format_exc()
            print(f"Error en EmpresasViewSet.list: {e}")
            print(error_trace)
            return Response(
                {'error': f'Error al obtener empresas: {str(e)}'},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )

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

    def list(self, request, *args, **kwargs):
        try:
            return super().list(request, *args, **kwargs)
        except Exception as e:
            import traceback
            error_trace = traceback.format_exc()
            print(f"Error en ContactosEmpresaViewSet.list: {e}")
            print(error_trace)
            return Response(
                {'error': f'Error al obtener contactos de empresa: {str(e)}'},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )


class OfertasEmpresasViewSet(viewsets.ModelViewSet):
    queryset = OfertasEmpresas.objects.all()
    serializer_class = OfertasEmpresasSerializer

    def list(self, request, *args, **kwargs):
        try:
            return super().list(request, *args, **kwargs)
        except Exception as e:
            import traceback
            error_trace = traceback.format_exc()
            print(f"Error en OfertasEmpresasViewSet.list: {e}")
            print(error_trace)
            return Response(
                {'error': f'Error al obtener ofertas: {str(e)}'},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )

    def create(self, request, *args, **kwargs):
        """
        Crear una nueva oferta. El serializer maneja toda la lógica de mapeo y validación.
        """
        try:
            # request.data en DRF ya es un dict procesado, pero asegurémonos
            # Convertir QueryDict a dict si es necesario
            if hasattr(request.data, 'dict'):
                # Es un QueryDict, convertir a dict
                data = request.data.dict()
            elif hasattr(request.data, 'copy'):
                data = request.data.copy()
            elif isinstance(request.data, dict):
                data = dict(request.data)
            else:
                data = {}

            # Asegurar que los valores de lista se conviertan a valores simples
            # (QueryDict puede devolver listas para claves duplicadas)
            for key, value in data.items():
                if isinstance(value, list) and len(value) == 1:
                    data[key] = value[0]
                elif isinstance(value, list) and len(value) == 0:
                    data[key] = None

            print(f"Datos recibidos del frontend: {data}")
            print(f"Tipo de datos: {type(data)}")
            print(f"Claves en data: {list(data.keys()) if isinstance(data, dict) else 'No es dict'}")
            print(f"Valor de 'empresa' en data: {data.get('empresa')}, tipo: {type(data.get('empresa'))}")
            print(f"Valor de 'empresa_id' en data: {data.get('empresa_id')}, tipo: {type(data.get('empresa_id'))}")

            # Validar que empresa esté presente - intentar múltiples formas
            empresa_value = None

            # Intentar obtener empresa de diferentes campos
            if 'empresa' in data and data.get('empresa'):
                empresa_value = data.get('empresa')
            elif 'empresa_id' in data and data.get('empresa_id'):
                empresa_value = data.get('empresa_id')
                data['empresa'] = empresa_value
            elif 'empresa' in data:
                # Puede ser 0, None, o string vacío
                empresa_value = data.get('empresa')

            # Convertir a entero si es string
            if empresa_value is not None:
                try:
                    if isinstance(empresa_value, str):
                        empresa_value = int(empresa_value) if empresa_value.strip() else None
                    elif isinstance(empresa_value, (int, float)):
                        empresa_value = int(empresa_value)
                except (ValueError, TypeError):
                    empresa_value = None

            if not empresa_value or empresa_value == 0:
                print(f"ERROR: empresa no encontrado. Datos recibidos: {data}")
                return Response(
                    {
                        'error': 'El campo empresa es requerido',
                        'detalle': 'No se recibió el ID de la empresa. Asegúrate de estar autenticado como empresa.'
                    },
                    status=status.HTTP_400_BAD_REQUEST
                )

            # Asegurar que empresa esté en data como entero
            empresa_id_final = int(empresa_value)
            data['empresa'] = empresa_id_final
            # También asegurar empresa_id por compatibilidad
            data['empresa_id'] = empresa_id_final

            # Verificar que la empresa exista antes de pasar al serializer
            try:
                from .models import Empresas
                empresa_obj = Empresas.objects.get(pk=empresa_id_final)
                print(f"✓ Empresa identificada y verificada: {empresa_id_final} ({empresa_obj.nombre_comercial or empresa_obj.razon_social})")
            except Empresas.DoesNotExist:
                return Response(
                    {
                        'error': f'La empresa con ID {empresa_id_final} no existe en la base de datos.',
                        'detalle': 'Verifica que el ID de empresa sea correcto.'
                    },
                    status=status.HTTP_400_BAD_REQUEST
                )

            print(f"Datos finales antes del serializer: {data}")
            print(f"Claves en data: {list(data.keys())}")
            print(f"Valor de empresa: {data.get('empresa')}, tipo: {type(data.get('empresa'))}")

            # El serializer manejará todo el mapeo y validación
            serializer = self.get_serializer(data=data)
            print(f"Serializer creado, validando datos...")
            serializer.is_valid(raise_exception=True)
            print(f"✓ Validación del serializer exitosa")
            self.perform_create(serializer)
            headers = self.get_success_headers(serializer.data)
            return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)
        except serializers.ValidationError as e:
            print(f"Error de validación: {e}")
            return Response(
                {'error': f'Error de validación: {str(e.detail)}'},
                status=status.HTTP_400_BAD_REQUEST
            )
        except Exception as e:
            import traceback
            error_trace = traceback.format_exc()
            print(f"Error en OfertasEmpresasViewSet.create: {e}")
            print(error_trace)
            print(f"Tipo de error: {type(e).__name__}")
            error_message = str(e)
            if hasattr(e, 'detail'):
                error_message = str(e.detail)
            elif hasattr(e, 'args') and e.args:
                error_message = str(e.args[0])
            # Incluir más detalles del error para debugging
            error_response = {
                'error': f'Error al crear la oferta: {error_message}',
                'error_type': type(e).__name__
            }
            return Response(
                error_response,
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
            from django.db.models import Q, Value, CharField
            from django.db.models.functions import Concat
            
            usuario = Estudiantes.objects.annotate(
                full_name=Concat('nombres', Value(' '), 'apellidos', output_field=CharField()),
                reverse_name=Concat('apellidos', Value(' '), 'nombres', output_field=CharField())
            ).filter(
                (Q(full_name__icontains=nombre_completo) | 
                 Q(reverse_name__icontains=nombre_completo) |
                 Q(nombres__icontains=nombre_completo) |
                 Q(apellidos__icontains=nombre_completo)),
                numero_documento=numero_documento
            ).first()
            
            if not usuario:
                raise Estudiantes.DoesNotExist
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
                    from django.db.models import Q, Value, CharField
                    from django.db.models.functions import Concat
                    
                    # Buscar estudiante por nombres y apellidos combinados
                    # Intentamos varias combinaciones para ser flexibles
                    usuario = Estudiantes.objects.annotate(
                        full_name=Concat('nombres', Value(' '), 'apellidos', output_field=CharField()),
                        reverse_name=Concat('apellidos', Value(' '), 'nombres', output_field=CharField())
                    ).filter(
                        (Q(full_name__icontains=nombre_completo) | 
                         Q(reverse_name__icontains=nombre_completo) |
                         Q(nombres__icontains=nombre_completo) |
                         Q(apellidos__icontains=nombre_completo)),
                        numero_documento=numero_documento
                    ).first()
                    
                    if not usuario:
                        raise Estudiantes.DoesNotExist
                        
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
    # Importación lazy para evitar errores de grpc al iniciar el servidor
    try:
        import google.generativeai as genai
        genai.configure(api_key=os.getenv("AIzaSyDlrQj_C8iSkOwdRli8aJxQGH7I898TuXM"))
    except ImportError:
        return Response({"error": "Google Generative AI no está disponible"}, status=status.HTTP_503_SERVICE_UNAVAILABLE)
    except Exception as e:
        return Response({"error": f"Error al configurar Generative AI: {str(e)}"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

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
