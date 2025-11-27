import os
import django
import sys
import json

# Setup Django environment
sys.path.append(os.path.join(os.path.dirname(__file__), 'backendCoformacion'))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'backend_uniempresarial.settings')
django.setup()

from coformacion.serializers import EstudiantesSerializer
from coformacion.models import Programas, Facultades

def debug_student_creation():
    print("Setting up debug data...")
    
    # Ensure a program exists
    facultad, _ = Facultades.objects.get_or_create(nombre="Facultad Debug")
    programa, _ = Programas.objects.get_or_create(
        codigo="DEBUG001", 
        defaults={
            "nombre": "Programa Debug", 
            "facultad_id": facultad,
            "duracion_semestres": 10,
            "modalidad": "Presencial",
            "nivel": "Profesional"
        }
    )

    # Simulate frontend data
    data = {
        "codigo_estudiante": "99887766",
        # "nombre_completo": "Debug Student", # Removed from frontend
        "nombres": "Debug", 
        "apellidos": "Student",
        "tipo_documento": "CC",
        "numero_documento": "99887766",
        "fecha_nacimiento": "2000-01-01",
        "genero": "M",
        "celular": "3001234567",
        "email_institucional": "debug.student@test.com",
        "programa_id": programa.programa_id,
        "semestre": 1,
        "jornada": "Diurna",
        "estado": "Activo",
        "fecha_ingreso": "2023-01-01",
        "contacto_emergencia": {
            "nombres": "Emergency",
            "apellidos": "Contact",
            "parentesco": "Padre",
            "celular": "3009876543",
            "telefono": "6012345678",
            "correo": "emergency@test.com"
        }
    }

    print("\nValidating data...")
    serializer = EstudiantesSerializer(data=data)
    
    if serializer.is_valid():
        print("✅ Data is VALID")
        # Don't save to avoid cluttering DB, just checking validation
        # serializer.save() 
    else:
        print("❌ Data is INVALID")
        print("Errors:", json.dumps(serializer.errors, indent=2))

if __name__ == "__main__":
    try:
        debug_student_creation()
    except Exception as e:
        print(f"An error occurred: {e}")
        import traceback
        traceback.print_exc()
