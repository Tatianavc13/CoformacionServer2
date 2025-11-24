#!/usr/bin/env python
"""
Script para verificar la conexión usando Django (más confiable)
Este script usa la misma configuración que Django usa en producción
"""

import os
import sys
import django

# Configurar Django
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'backend_uniempresarial.settings')

try:
    django.setup()
except Exception as e:
    print(f"❌ Error al configurar Django: {e}")
    print("\nAsegúrate de estar en el directorio backendCoformacion")
    sys.exit(1)

from django.db import connection
from django.conf import settings

def test_django_db_connection():
    """Prueba la conexión usando Django"""
    print("=" * 60)
    print("PRUEBA DE CONEXIÓN USANDO DJANGO")
    print("=" * 60)

    # Mostrar configuración
    db_config = settings.DATABASES['default']
    print("\n1. Configuración de Django:")
    print(f"   Engine: {db_config.get('ENGINE', 'N/A')}")
    print(f"   Name: {db_config.get('NAME', 'N/A')}")
    print(f"   Host: {db_config.get('HOST', 'N/A')}")
    print(f"   Port: {db_config.get('PORT', 'N/A')}")
    print(f"   User: {db_config.get('USER', 'N/A')}")

    try:
        print("\n2. Probando conexión...")
        with connection.cursor() as cursor:
            # Prueba simple
            cursor.execute("SELECT 1")
            result = cursor.fetchone()
            if result:
                print("   ✅ Conexión exitosa!")

            # Versión de MySQL
            cursor.execute("SELECT VERSION()")
            version = cursor.fetchone()[0]
            print(f"   ✅ Versión de MySQL: {version}")

            # Base de datos actual
            cursor.execute("SELECT DATABASE()")
            current_db = cursor.fetchone()[0]
            print(f"   ✅ Base de datos actual: {current_db}")

            # Listar tablas
            print("\n3. Tablas disponibles:")
            cursor.execute("SHOW TABLES")
            tables = cursor.fetchall()
            if tables:
                print(f"   ✅ Se encontraron {len(tables)} tablas:")
                for table in tables[:10]:
                    print(f"      - {table[0]}")
                if len(tables) > 10:
                    print(f"      ... y {len(tables) - 10} más")
            else:
                print("   ⚠️  No se encontraron tablas")

            # Contar registros
            print("\n4. Registros en tablas principales:")

            # Estudiantes
            try:
                cursor.execute("SELECT COUNT(*) FROM estudiantes")
                count = cursor.fetchone()[0]
                print(f"   ✅ Estudiantes: {count} registros")

                if count > 0:
                    cursor.execute("SELECT nombre_completo, numero_documento FROM estudiantes LIMIT 3")
                    estudiantes = cursor.fetchall()
                    print("      Ejemplos:")
                    for est in estudiantes:
                        print(f"         - {est[0]} (Doc: {est[1]})")
            except Exception as e:
                print(f"   ⚠️  Error al consultar estudiantes: {e}")

            # Empresas
            try:
                cursor.execute("SELECT COUNT(*) FROM empresas")
                count = cursor.fetchone()[0]
                print(f"   ✅ Empresas: {count} registros")

                if count > 0:
                    cursor.execute("SELECT nombre_comercial, razon_social, nit FROM empresas LIMIT 3")
                    empresas = cursor.fetchall()
                    print("      Ejemplos:")
                    for emp in empresas:
                        nombre = emp[0] or emp[1] or "Sin nombre"
                        print(f"         - {nombre} (NIT: {emp[2]})")
            except Exception as e:
                print(f"   ⚠️  Error al consultar empresas: {e}")

        print("\n" + "=" * 60)
        print("✅ VERIFICACIÓN COMPLETA - Django puede conectarse a la BD")
        print("=" * 60)
        return True

    except Exception as e:
        print(f"\n❌ Error de conexión: {e}")
        print(f"   Tipo de error: {type(e).__name__}")

        # Información adicional
        error_str = str(e)
        if "2003" in error_str or "Can't connect" in error_str:
            print("\n   💡 MySQL no está corriendo o no es accesible")
        elif "1045" in error_str or "Access denied" in error_str:
            print("\n   💡 Credenciales incorrectas")
        elif "1049" in error_str or "Unknown database" in error_str:
            print("\n   💡 La base de datos no existe")

        import traceback
        print("\nTraceback completo:")
        traceback.print_exc()
        return False

if __name__ == '__main__':
    try:
        success = test_django_db_connection()
        sys.exit(0 if success else 1)
    except Exception as e:
        print(f"\n❌ Error fatal: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)


