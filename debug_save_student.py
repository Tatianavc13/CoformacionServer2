import os
import django
import sys
import json

# Setup Django environment
sys.path.append(os.path.join(os.path.dirname(__file__), 'backendCoformacion'))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'backend_uniempresarial.settings')
django.setup()

from coformacion.serializers import EstudiantesSerializer
from coformacion.models import Programas, Facultades, Estudiantes

def debug_save_student():
    print("Setting up debug data...")
    
    # Ensure a program exists
    facultad, _ = Facultades.objects.get_or_create(nombre="Facultad Debug")
    programa, _ = Programas.objects.get_or_create(
        codigo="DEBUG003", 
        defaults={
            "nombre": "Programa Debug 3", 
            "facultad_id": facultad,
            "duracion_semestres": 10,
            "modalidad": "Presencial",
            "nivel": "Profesional"
        }
    )

    # Clean up previous test run if exists
    Estudiantes.objects.filter(codigo_estudiante="99887744").delete()

    # Simulate frontend data
    data = {
        "codigo_estudiante": "99887744",
        "nombres": "Debug Save 2", 
        "apellidos": "Student 2",
        "tipo_documento": "CC",
        "numero_documento": "99887744",
        "fecha_nacimiento": "2000-01-01",
        "genero": "M",
        "celular": "3001234567",
        "email_institucional": "debug.save2@test.com",
        "programa_id": programa.programa_id,
        "semestre": 1,
        "jornada": "Diurna",
        "estado": "Activo",
        "fecha_ingreso": "2023-01-01",
        "contacto_emergencia": {
            "nombres": "Emergency",
            "apellidos": "Contact",
            "parentesco": "Padre",
            "celular": "3213211789", # Large number that caused overflow
            "telefono": "6012345678",
            "correo": "emergency@test.com"
        }
    }

    print("\nValidating and Saving data...")
    serializer = EstudiantesSerializer(data=data)
    
    if serializer.is_valid():
        print("✅ Data is VALID. Attempting save...")
        try:
            instance = serializer.save()
            print(f"✅ Student saved successfully: ID {instance.estudiante_id}")
        except Exception as e:
            print(f"❌ Error during save: {e}")
            import traceback
            traceback.print_exc()
    else:
        print("❌ Data is INVALID")
        print("Errors:", json.dumps(serializer.errors, indent=2))

if __name__ == "__main__":
    try:
        debug_save_student()
    except Exception as e:
        print(f"An error occurred: {e}")
        import traceback
        traceback.print_exc()
