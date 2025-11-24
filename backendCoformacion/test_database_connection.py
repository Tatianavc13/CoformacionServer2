#!/usr/bin/env python
"""
Script para verificar la conexión a la base de datos MySQL
Ejecutar desde el directorio backendCoformacion con el venv activado
"""

import os
import sys
import django

# Configurar Django
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'backend_uniempresarial.settings')
django.setup()

from django.db import connection
from django.conf import settings
from coformacion.models import Estudiantes, Empresas, Coformacion

def test_database_connection():
    """Prueba la conexión a la base de datos"""
    print("=" * 60)
    print("PRUEBA DE CONEXIÓN A LA BASE DE DATOS")
    print("=" * 60)

    # 1. Verificar configuración de la base de datos
    print("\n1. Configuración de la Base de Datos:")
    db_config = settings.DATABASES['default']
    print(f"   Engine: {db_config.get('ENGINE', 'N/A')}")
    print(f"   Name: {db_config.get('NAME', 'N/A')}")
    print(f"   Host: {db_config.get('HOST', 'N/A')}")
    print(f"   Port: {db_config.get('PORT', 'N/A')}")
    print(f"   User: {db_config.get('USER', 'N/A')}")

    # 2. Probar conexión
    print("\n2. Probando conexión...")
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT 1")
            result = cursor.fetchone()
            if result:
                print("   ✅ Conexión exitosa a la base de datos!")
            else:
                print("   ❌ Error: No se pudo obtener respuesta de la base de datos")
                return False
    except Exception as e:
        print(f"   ❌ Error de conexión: {str(e)}")
        return False

    # 3. Verificar que las tablas existan
    print("\n3. Verificando tablas...")
    try:
        with connection.cursor() as cursor:
            cursor.execute("SHOW TABLES")
            tables = cursor.fetchall()
            table_names = [table[0] for table in tables]
            print(f"   ✅ Se encontraron {len(table_names)} tablas en la base de datos")

            # Verificar tablas importantes
            important_tables = ['estudiantes', 'empresas', 'coformacion']
            for table in important_tables:
                if table in table_names:
                    print(f"      ✅ Tabla '{table}' existe")
                else:
                    print(f"      ⚠️  Tabla '{table}' NO existe")
    except Exception as e:
        print(f"   ❌ Error al verificar tablas: {str(e)}")
        return False

    # 4. Contar registros en tablas principales
    print("\n4. Contando registros en tablas principales...")
    try:
        estudiantes_count = Estudiantes.objects.count()
        print(f"   ✅ Estudiantes: {estudiantes_count} registros")

        empresas_count = Empresas.objects.count()
        print(f"   ✅ Empresas: {empresas_count} registros")

        try:
            coformacion_count = Coformacion.objects.count()
            print(f"   ✅ Coformación: {coformacion_count} registros")
        except Exception as e:
            print(f"   ⚠️  Coformación: Tabla no disponible o vacía")
    except Exception as e:
        print(f"   ❌ Error al contar registros: {str(e)}")
        return False

    # 5. Probar consulta de ejemplo
    print("\n5. Probando consulta de ejemplo...")
    try:
        # Buscar un estudiante de ejemplo
        estudiantes = Estudiantes.objects.all()[:3]
        if estudiantes:
            print(f"   ✅ Se encontraron {len(estudiantes)} estudiantes de ejemplo:")
            for estudiante in estudiantes:
                print(f"      - {estudiante.nombre_completo} (Doc: {estudiante.numero_documento})")
        else:
            print("   ⚠️  No hay estudiantes en la base de datos")

        # Buscar una empresa de ejemplo
        empresas = Empresas.objects.all()[:3]
        if empresas:
            print(f"   ✅ Se encontraron {len(empresas)} empresas de ejemplo:")
            for empresa in empresas:
                nombre = empresa.nombre_comercial or empresa.razon_social
                print(f"      - {nombre} (NIT: {empresa.nit})")
        else:
            print("   ⚠️  No hay empresas en la base de datos")
    except Exception as e:
        print(f"   ❌ Error al hacer consulta de ejemplo: {str(e)}")
        return False

    # 6. Verificar versión de MySQL
    print("\n6. Información del servidor MySQL...")
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT VERSION()")
            version = cursor.fetchone()[0]
            print(f"   ✅ Versión de MySQL: {version}")
    except Exception as e:
        print(f"   ⚠️  No se pudo obtener la versión: {str(e)}")

    print("\n" + "=" * 60)
    print("✅ VERIFICACIÓN COMPLETA - Base de datos conectada correctamente")
    print("=" * 60)
    return True

if __name__ == '__main__':
    try:
        success = test_database_connection()
        sys.exit(0 if success else 1)
    except Exception as e:
        print(f"\n❌ Error fatal: {str(e)}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

