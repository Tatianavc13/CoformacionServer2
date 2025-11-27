#!/usr/bin/env python
"""
Script para probar una solicitud HTTP POST al servidor Django
Simula lo que Angular envía cuando crea un estudiante
"""
import requests
import json
from datetime import datetime

BASE_URL = "http://127.0.0.1:8000"  # Ajusta al puerto correcto si es diferente
STUDENTS_ENDPOINT = f"{BASE_URL}/api/estudiantes/"

# Datos de prueba que simula lo que Angular envía
test_data = {
    "codigo_estudiante": "TEST20251127B",
    "nombres": "Carlos",
    "apellidos": "García",
    "tipo_documento": "CC",
    "numero_documento": "98765432101",
    "fecha_nacimiento": "1999-05-20",
    "genero": "M",
    "celular": "3109876543",
    "email_institucional": "carlos.garcia@test.edu.co",
    "programa_id": 1,  # Como número
    "semestre": 2,  # Como número
    "jornada": "Diurna",
    "estado": "Activo",
    "fecha_ingreso": "2024-01-15",
    "nivel_ingles_id": None,
    "promocion_id": None,
    "estado_cartera_id": None,
    "contacto_emergencia": {
        "nombres": "Rosa",
        "apellidos": "López",
        "parentesco": "Tía",
        "celular": "3115559999",
        "telefono": "6019876543",
        "correo": "rosa.lopez@gmail.com"
    }
}

print("\n" + "="*80)
print("TEST HTTP POST: Creación de Estudiante con Contacto de Emergencia")
print("="*80)

print(f"\nURL: {STUDENTS_ENDPOINT}")
print(f"Método: POST")

print("\nDatos a enviar:")
print(json.dumps(test_data, indent=2, ensure_ascii=False, default=str))

try:
    print("\nEnviando solicitud...")
    response = requests.post(
        STUDENTS_ENDPOINT,
        json=test_data,
        headers={"Content-Type": "application/json"}
    )
    
    print(f"\nRespuesta del servidor:")
    print(f"Status Code: {response.status_code}")
    print(f"Headers: {dict(response.headers)}")
    
    try:
        print(f"\nDatos de respuesta:")
        print(json.dumps(response.json(), indent=2, ensure_ascii=False, default=str))
    except:
        print(f"\nContenido de respuesta (texto):")
        print(response.text)
    
    if response.status_code == 201 or response.status_code == 200:
        print("\n✅ Solicitud exitosa")
    else:
        print(f"\n❌ Error {response.status_code}")
        
except Exception as e:
    print(f"\n❌ Error durante la solicitud HTTP:")
    print(f"   {str(e)}")
    import traceback
    traceback.print_exc()

finally:
    print("\n" + "="*80)
    print("Fin de prueba")
    print("="*80 + "\n")
