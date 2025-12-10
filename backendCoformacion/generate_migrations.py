#!/usr/bin/env python
"""
Script para generar migraciones de forma no interactiva
"""
import os
import sys
import django
from io import StringIO

# Configurar Django
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'backend_uniempresarial.settings')
django.setup()

from django.core.management import call_command
from django.core.management.base import CommandError

# Simular respuestas a preguntas interactivas
import builtins
original_input = builtins.input

def mock_input(prompt=""):
    if "renamed" in str(prompt).lower():
        return "N"  # No, no fue renombrado
    elif "default" in str(prompt).lower():
        return "1"  # Opción 1: proporcionar un valor por defecto
    elif "one-off default" in str(prompt).lower():
        return ""  # Valor vacío o usar el valor por defecto del modelo
    return ""

builtins.input = mock_input

try:
    print("Generando migraciones...")
    call_command('makemigrations', 'coformacion', name='sync_with_database', verbosity=2)
    print("\n✅ Migraciones generadas exitosamente!")
except CommandError as e:
    print(f"\n⚠️  Error: {e}")
    print("Esto puede ser normal si no hay cambios detectados.")
except Exception as e:
    print(f"\n❌ Error inesperado: {e}")
    import traceback
    traceback.print_exc()
finally:
    builtins.input = original_input

