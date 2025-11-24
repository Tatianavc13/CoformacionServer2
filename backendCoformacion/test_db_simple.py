#!/usr/bin/env python
"""
Script simple para verificar la conexión a la base de datos MySQL
Sin usar Django - conexión directa
"""

import mysql.connector
from mysql.connector import Error

def test_mysql_connection():
    """Prueba la conexión directa a MySQL"""
    print("=" * 60)
    print("PRUEBA DE CONEXIÓN DIRECTA A MYSQL")
    print("=" * 60)

    # Configuración de la base de datos
    config = {
        'host': '127.0.0.1',
        'port': 3307,
        'user': 'root',
        'password': '',
        'database': 'coformacion1'
    }

    print("\n1. Configuración:")
    print(f"   Host: {config['host']}")
    print(f"   Port: {config['port']}")
    print(f"   User: {config['user']}")
    print(f"   Database: {config['database']}")

    connection = None
    try:
        print("\n2. Intentando conectar...")
        # Intentar conectar con manejo de errores más detallado
        try:
            connection = mysql.connector.connect(**config)
        except Error as e:
            print(f"   ❌ Error de conexión: {e}")
            print(f"   Código de error: {e.errno if hasattr(e, 'errno') else 'N/A'}")
            print(f"   Mensaje SQL: {e.msg if hasattr(e, 'msg') else 'N/A'}")

            # Sugerencias según el tipo de error
            if hasattr(e, 'errno'):
                if e.errno == 2003:
                    print("\n   💡 Sugerencia: MySQL no está corriendo o no es accesible en ese puerto")
                    print("      - Verifica que MySQL esté ejecutándose")
                    print("      - Verifica que el puerto 3307 sea correcto")
                elif e.errno == 1045:
                    print("\n   💡 Sugerencia: Credenciales incorrectas")
                    print("      - Verifica el usuario y contraseña")
                elif e.errno == 1049:
                    print("\n   💡 Sugerencia: La base de datos no existe")
                    print("      - Crea la base de datos: CREATE DATABASE coformacion1;")

            raise

        if connection.is_connected():
            db_info = connection.get_server_info()
            print(f"   ✅ Conexión exitosa!")
            print(f"   ✅ Versión de MySQL: {db_info}")

            # Obtener información de la base de datos
            cursor = connection.cursor()

            # Verificar que estamos en la base de datos correcta
            cursor.execute("SELECT DATABASE()")
            current_db = cursor.fetchone()[0]
            print(f"   ✅ Base de datos actual: {current_db}")

            # Listar tablas
            print("\n3. Tablas disponibles:")
            cursor.execute("SHOW TABLES")
            tables = cursor.fetchall()
            if tables:
                print(f"   ✅ Se encontraron {len(tables)} tablas:")
                for table in tables[:10]:  # Mostrar solo las primeras 10
                    print(f"      - {table[0]}")
                if len(tables) > 10:
                    print(f"      ... y {len(tables) - 10} más")
            else:
                print("   ⚠️  No se encontraron tablas")

            # Contar registros en tablas principales
            print("\n4. Registros en tablas principales:")

            # Estudiantes
            try:
                cursor.execute("SELECT COUNT(*) FROM estudiantes")
                count = cursor.fetchone()[0]
                print(f"   ✅ Estudiantes: {count} registros")

                # Mostrar algunos ejemplos
                if count > 0:
                    cursor.execute("SELECT nombre_completo, numero_documento FROM estudiantes LIMIT 3")
                    estudiantes = cursor.fetchall()
                    print("      Ejemplos:")
                    for est in estudiantes:
                        print(f"         - {est[0]} (Doc: {est[1]})")
            except Error as e:
                print(f"   ⚠️  Error al consultar estudiantes: {e}")

            # Empresas
            try:
                cursor.execute("SELECT COUNT(*) FROM empresas")
                count = cursor.fetchone()[0]
                print(f"   ✅ Empresas: {count} registros")

                # Mostrar algunos ejemplos
                if count > 0:
                    cursor.execute("SELECT nombre_comercial, razon_social, nit FROM empresas LIMIT 3")
                    empresas = cursor.fetchall()
                    print("      Ejemplos:")
                    for emp in empresas:
                        nombre = emp[0] or emp[1] or "Sin nombre"
                        print(f"         - {nombre} (NIT: {emp[2]})")
            except Error as e:
                print(f"   ⚠️  Error al consultar empresas: {e}")

            cursor.close()

            print("\n" + "=" * 60)
            print("✅ VERIFICACIÓN COMPLETA - Base de datos conectada correctamente")
            print("=" * 60)
            return True

    except Error as e:
        print(f"\n❌ Error de conexión: {e}")
        if hasattr(e, 'errno'):
            print(f"   Código de error MySQL: {e.errno}")
        if hasattr(e, 'msg'):
            print(f"   Mensaje: {e.msg}")

        print("\n🔍 Diagnóstico:")
        print("1. Verifica que MySQL esté corriendo:")
        print("   - Abre el Administrador de Tareas (Task Manager)")
        print("   - Busca procesos de MySQL")
        print("   - O ejecuta: Get-Service | Where-Object {$_.Name -like '*mysql*'}")

        print("\n2. Prueba conectarte manualmente:")
        print("   mysql -u root -h 127.0.0.1 -P 3307")

        print("\n3. Verifica el puerto:")
        print("   - El puerto configurado es 3307")
        print("   - Si MySQL usa otro puerto (ej: 3306), cámbialo en settings.py")

        print("\n4. Verifica que la base de datos exista:")
        print("   mysql -u root -h 127.0.0.1 -P 3307 -e 'SHOW DATABASES;'")

        return False
    except Exception as e:
        print(f"\n❌ Error inesperado: {e}")
        import traceback
        print("\nTraceback completo:")
        traceback.print_exc()
        return False

    finally:
        if connection and connection.is_connected():
            connection.close()
            print("\n✅ Conexión cerrada correctamente")

if __name__ == '__main__':
    try:
        success = test_mysql_connection()
        exit(0 if success else 1)
    except Exception as e:
        print(f"\n❌ Error fatal: {e}")
        import traceback
        traceback.print_exc()
        exit(1)

