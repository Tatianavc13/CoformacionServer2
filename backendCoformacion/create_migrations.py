#!/usr/bin/env python
"""
Script para crear migraciones de forma no interactiva
"""
import os
import sys
import django

# Configurar Django
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'backend_uniempresarial.settings')
django.setup()

from django.core.management import call_command
from io import StringIO

# Capturar la salida
output = StringIO()

try:
    # Crear migraciones de forma no interactiva
    # Responder 'N' a la pregunta sobre renombrar campos
    # Y proporcionar valores por defecto para campos no nulos
    call_command('makemigrations', 'coformacion', 
                name='sync_with_database',
                interactive=False,
                stdout=output)
    print(output.getvalue())
    print("\n✅ Migraciones creadas exitosamente!")
except Exception as e:
    print(f"\n❌ Error al crear migraciones: {e}")
    import traceback
    traceback.print_exc()

