import os
import django
import sys

# Setup Django environment
sys.path.append(os.path.join(os.path.dirname(__file__), 'backendCoformacion'))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'backend_uniempresarial.settings')
django.setup()

from coformacion.models import Estudiantes, Programas, Facultades
from coformacion.views import login_universal
from rest_framework.test import APIRequestFactory
from django.test import RequestFactory
import json

def test_login():
    print("Setting up test data...")
    
    # Create dependencies if they don't exist
    facultad, _ = Facultades.objects.get_or_create(nombre="Facultad Test")
    programa, _ = Programas.objects.get_or_create(
        codigo="TEST001", 
        defaults={
            "nombre": "Programa Test", 
            "facultad_id": facultad,
            "duracion_semestres": 10,
            "modalidad": "Presencial",
            "nivel": "Profesional"
        }
    )
    
    # Create a test student
    Estudiantes.objects.filter(numero_documento="99999999").delete()
    estudiante = Estudiantes.objects.create(
        codigo_estudiante="TEST_USER",
        nombres="Juan Carlos",
        apellidos="Perez Gomez",
        tipo_documento="CC",
        numero_documento="99999999",
        fecha_nacimiento="2000-01-01",
        genero="M",
        celular="3001234567",
        email_institucional="juan.perez@test.com",
        programa_id=programa,
        semestre=1,
        jornada="Diurna",
        fecha_ingreso="2023-01-01"
    )
    
    print(f"Created student: {estudiante.nombres} {estudiante.apellidos} (Doc: {estudiante.numero_documento})")
    print(f"Computed nombre_completo: {estudiante.nombre_completo}")

    factory = APIRequestFactory()

    # Test cases
    test_cases = [
        "Juan Carlos Perez Gomez",
        "Perez Gomez Juan Carlos",
        "Juan Perez",
        "Perez Juan",
        "juan carlos",
        "perez gomez"
    ]

    print("\nStarting login tests...")
    
    for name_input in test_cases:
        print(f"\nTesting login with name: '{name_input}'")
        data = {
            "nombre_completo": name_input,
            "numero_documento": "99999999",
            "tipo_usuario": "estudiante"
        }
        
        request = factory.post('/api/login-universal/', data, format='json')
        response = login_universal(request)
        
        if response.status_code == 200:
            print(f"✅ Login SUCCESS for '{name_input}'")
            print(f"Response data name: {response.data['data']['nombre_completo']}")
        else:
            print(f"❌ Login FAILED for '{name_input}'")
            print(f"Status: {response.status_code}")
            print(f"Error: {response.data}")

    # Clean up
    print("\nCleaning up...")
    estudiante.delete()
    print("Done.")

if __name__ == "__main__":
    try:
        test_login()
    except Exception as e:
        print(f"An error occurred: {e}")
        import traceback
        traceback.print_exc()
