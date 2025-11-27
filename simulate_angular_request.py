#!/usr/bin/env python
"""
Simular exactamente lo que Angular está enviando al servidor
"""
import requests
import json

BASE_URL = "http://127.0.0.1:8000"
ENDPOINT = f"{BASE_URL}/api/estudiantes/"

# Esto es lo que Angular envía después de la corrección
# Exactamente como se prepara en agregar-estudiante.component.ts
angular_data = {
    "codigo_estudiante": "ANGULAR001",
    "nombres": "Test",
    "apellidos": "User",
    "tipo_documento": "CC",
    "numero_documento": "12345678999",
    "fecha_nacimiento": "2000-01-01",
    "genero": "M",
    "telefono": "",  # Puede estar vacío
    "celular": "3001234567",
    "email_institucional": "test@test.edu.co",
    "email_personal": "",  # Puede estar vacío
    "direccion": "",  # Puede estar vacío
    "ciudad": "",  # Puede estar vacío
    "programa_id": 1,  # Convertido a número
    "semestre": 1,  # Convertido a número
    "jornada": "Diurna",
    "promedio_acumulado": None,
    "estado": "Activo",
    "fecha_ingreso": "2024-01-01",
    "nivel_ingles_id": None,
    "promocion_id": None,
    "estado_cartera_id": None,
    "foto_url": "",  # Puede estar vacío
    "contacto_emergencia": {
        "nombres": "Maria",
        "apellidos": "Ramirez",
        "parentesco": "Madre",
        "celular": "3213211789",
        "telefono": "6012345678",
        "correo": "ospinmary1972@gmail.com"
    }
}

print("\n" + "="*80)
print("Simulando solicitud HTTP POST como Angular")
print("="*80)
print(f"\nURL: {ENDPOINT}")
print(f"Método: POST")
print(f"\nDatos (JSON):")
print(json.dumps(angular_data, indent=2, ensure_ascii=False))

try:
    response = requests.post(
        ENDPOINT,
        json=angular_data,
        headers={"Content-Type": "application/json"}
    )
    
    print(f"\n\nRespuesta del servidor:")
    print(f"Status Code: {response.status_code}")
    
    try:
        response_json = response.json()
        print(f"\nRespuesta (JSON):")
        print(json.dumps(response_json, indent=2, ensure_ascii=False, default=str))
    except:
        print(f"\nRespuesta (Texto):")
        print(response.text)
    
    if response.status_code in [200, 201]:
        print("\n✅ ÉXITO - La solicitud fue procesada correctamente")
    else:
        print(f"\n❌ ERROR {response.status_code}")
        print("\nPosibles causas:")
        print("1. Los datos enviados no coinciden con el esquema de la BD")
        print("2. Hay validadores en el serializer que rechazan los datos")
        print("3. Hay una restricción de unique_together que se viola")
        
except requests.exceptions.ConnectionError:
    print("\n❌ Error: No se puede conectar al servidor")
    print("Verifica que Django esté corriendo en http://127.0.0.1:8000")
except Exception as e:
    print(f"\n❌ Error: {e}")

print("\n" + "="*80)
