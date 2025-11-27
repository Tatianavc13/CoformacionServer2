#!/usr/bin/env python
"""
Test script para validar la creación de estudiantes con contactos de emergencia
"""
import os
import sys
import django
from decimal import Decimal

# Configurar Django
sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'backendCoformacion'))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'backend_uniempresarial.settings')
django.setup()

from coformacion.models import Estudiantes, ContactosDeEmergencia, Programas
from coformacion.serializers import EstudiantesSerializer
from django.utils import timezone
from datetime import datetime, date

print("\n" + "="*80)
print("TEST: Validación de Creación de Estudiantes con Contactos de Emergencia")
print("="*80)

try:
    # Obtener o crear un programa
    print("\n1. Buscando programa para el estudiante...")
    programa = Programas.objects.first()
    if not programa:
        print("❌ No hay programas en la base de datos")
        sys.exit(1)
    print(f"✅ Programa encontrado: {programa.nombre}")

    # Datos de prueba
    test_data = {
        "codigo_estudiante": "TEST20251127",
        "nombres": "Juan",
        "apellidos": "Pérez",
        "tipo_documento": "CC",
        "numero_documento": "12345678901",
        "fecha_nacimiento": "2000-01-15",
        "genero": "M",
        "celular": "3001234567",
        "email_institucional": "juan.perez@test.edu.co",
        "programa_id": programa.programa_id,
        "semestre": 1,
        "jornada": "Diurna",
        "estado": "Activo",
        "fecha_ingreso": "2024-01-01",
        "contacto_emergencia": {
            "nombres": "Maria",
            "apellidos": "Ramirez",
            "parentesco": "Madre",
            "celular": "3213211789",
            "telefono": "6012345678",
            "correo": "ospinmary1972@gmail.com"
        }
    }

    print("\n2. Validando datos con el serializer...")
    serializer = EstudiantesSerializer(data=test_data)
    
    if serializer.is_valid():
        print("✅ Datos válidos - El serializer acepta la estructura")
        print("\nCampos validados correctamente:")
        for field, value in test_data.items():
            if isinstance(value, dict):
                print(f"  - {field}:")
                for k, v in value.items():
                    print(f"      • {k}: {v}")
            else:
                print(f"  - {field}: {value}")
        
        # Guardar
        print("\n3. Intentando guardar el estudiante...")
        instance = serializer.save()
        print(f"✅ Estudiante guardado: {instance.nombre_completo}")
        print(f"   ID: {instance.estudiante_id}")
        
        # Verificar contacto
        contacto = ContactosDeEmergencia.objects.filter(estudiante=instance).first()
        if contacto:
            print(f"\n✅ Contacto de emergencia guardado:")
            print(f"   Nombre: {contacto.nombres} {contacto.apellidos}")
            print(f"   Parentesco: {contacto.parentesco}")
            print(f"   Celular: {contacto.celular}")
            print(f"   Teléfono: {contacto.telefono}")
            print(f"   Correo: {contacto.correo}")
        else:
            print("❌ El contacto de emergencia NO fue guardado")

    else:
        print("❌ Errores en la validación:")
        for field, errors in serializer.errors.items():
            print(f"\n  {field}:")
            for error in errors:
                print(f"    - {error}")

except Exception as e:
    print(f"\n❌ Error durante la prueba:")
    print(f"   {str(e)}")
    import traceback
    traceback.print_exc()

finally:
    print("\n" + "="*80)
    print("Fin de prueba")
    print("="*80 + "\n")
