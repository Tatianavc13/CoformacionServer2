#!/usr/bin/env python
"""
Script de diagnóstico para encontrar exactamente qué está fallando
al crear un estudiante con contacto de emergencia
"""
import os
import sys
import django
import json
from decimal import Decimal

sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'backendCoformacion'))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'backend_uniempresarial.settings')
django.setup()

from coformacion.models import Estudiantes, ContactosDeEmergencia, Programas
from coformacion.serializers import EstudiantesSerializer
from django.db import transaction
from rest_framework.test import APIRequestFactory

print("\n" + "="*100)
print("DIAGNÓSTICO: Prueba completa de creación de estudiante con contacto de emergencia")
print("="*100)

# 1. Verificar que exista un programa
print("\n[1] Verificando programa disponible...")
try:
    programa = Programas.objects.first()
    if not programa:
        print("❌ No hay programas en la BD")
        sys.exit(1)
    print(f"✅ Programa: {programa.nombre} (ID: {programa.programa_id})")
except Exception as e:
    print(f"❌ Error obteniendo programa: {e}")
    sys.exit(1)

# 2. Datos de prueba
print("\n[2] Preparando datos de prueba...")
test_data = {
    "codigo_estudiante": "TEST20251127C",
    "nombres": "Fernando",
    "apellidos": "Sánchez",
    "tipo_documento": "CC",
    "numero_documento": "99887766551",
    "fecha_nacimiento": "1998-03-25",
    "genero": "M",
    "celular": "3125559999",
    "email_institucional": "fernando.sanchez@test.edu.co",
    "programa_id": programa.programa_id,
    "semestre": 3,
    "jornada": "Diurna",
    "estado": "Activo",
    "fecha_ingreso": "2024-01-01",
    "contacto_emergencia": {
        "nombres": "Patricia",
        "apellidos": "Gómez",
        "parentesco": "Hermana",
        "celular": "3215559888",
        "telefono": "6019999999",
        "correo": "patricia.gomez@email.com"
    }
}

print(f"Datos preparados:")
print(json.dumps(test_data, indent=2, ensure_ascii=False))

# 3. Probar serialización
print("\n[3] Probando serialización...")
serializer = EstudiantesSerializer(data=test_data)

if not serializer.is_valid():
    print("❌ Error en validación del serializer:")
    for field, errors in serializer.errors.items():
        print(f"\n  Campo: {field}")
        for error in errors:
            print(f"    - {error}")
    
    # Intentar más detalles
    print("\n[!] Intentando encontrar el problema específico...")
    
    # Probar sin contacto_emergencia
    print("\n  [a] Probando SIN contacto_emergencia...")
    data_sin_contacto = {k: v for k, v in test_data.items() if k != 'contacto_emergencia'}
    ser_sin = EstudiantesSerializer(data=data_sin_contacto)
    if ser_sin.is_valid():
        print("  ✅ Sin contacto_emergencia es válido")
    else:
        print("  ❌ Error sin contacto_emergencia:")
        for field, errors in ser_sin.errors.items():
            print(f"     {field}: {errors}")
    
    # Probar contacto_emergencia solo
    print("\n  [b] Probando datos del contacto_emergencia...")
    contacto_data = test_data["contacto_emergencia"]
    from coformacion.serializers import ContactosDeEmergenciaSerializer
    ser_contacto = ContactosDeEmergenciaSerializer(data=contacto_data)
    if ser_contacto.is_valid():
        print("  ✅ Datos de contacto_emergencia son válidos")
    else:
        print("  ❌ Error en contacto_emergencia:")
        for field, errors in ser_contacto.errors.items():
            print(f"     {field}: {errors}")
    
    sys.exit(1)
else:
    print("✅ Datos válidos en serializer")

# 4. Guardar
print("\n[4] Intentando guardar...")
try:
    with transaction.atomic():
        estudiante = serializer.save()
        print(f"✅ Estudiante guardado: {estudiante.nombre_completo} (ID: {estudiante.estudiante_id})")
        
        # Verificar contacto
        contacto = ContactosDeEmergencia.objects.filter(estudiante=estudiante).first()
        if contacto:
            print(f"✅ Contacto de emergencia guardado:")
            print(f"   - Nombre: {contacto.nombres} {contacto.apellidos}")
            print(f"   - Parentesco: {contacto.parentesco}")
            print(f"   - Celular: {contacto.celular}")
            print(f"   - Teléfono: {contacto.telefono}")
            print(f"   - Correo: {contacto.correo}")
        else:
            print("❌ Contacto de emergencia NO fue guardado")
            
except Exception as e:
    print(f"❌ Error al guardar: {e}")
    import traceback
    traceback.print_exc()
    
    # Intentar información adicional
    print("\n[!] Información de debug:")
    print(f"  Tipo de error: {type(e).__name__}")
    sys.exit(1)

print("\n" + "="*100)
print("✅ PRUEBA EXITOSA - El problema NO está en el backend")
print("="*100 + "\n")
