#!/usr/bin/env python
"""
Script alternativo para verificar la conexión usando PyMySQL
PyMySQL es más simple y no requiere bibliotecas C de MySQL
"""

try:
    import pymysql
    pymysql.install_as_MySQLdb()  # Hace que PyMySQL funcione como MySQLdb
    USE_PYMYSQL = True
except ImportError:
    USE_PYMYSQL = False
    print("⚠️  PyMySQL no está instalado. Instalando...")
    import subprocess
    import sys
    subprocess.check_call([sys.executable, "-m", "pip", "install", "PyMySQL"])
    import pymysql
    pymysql.install_as_MySQLdb()
    USE_PYMYSQL = True

def test_mysql_connection():
    """Prueba la conexión usando PyMySQL"""
    print("=" * 60)
    print("PRUEBA DE CONEXIÓN A MYSQL (usando PyMySQL)")
    print("=" * 60)

    # Configuración de la base de datos
    config = {
        'host': '127.0.0.1',
        'port': 3307,
        'user': 'root',
        'password': '',
        'database': 'coformacion1',
        'charset': 'utf8mb4'
    }

    print("\n1. Configuración:")
    print(f"   Host: {config['host']}")
    print(f"   Port: {config['port']}")
    print(f"   User: {config['user']}")
    print(f"   Database: {config['database']}")

    connection = None
    try:
        print("\n2. Intentando conectar con PyMySQL...")
        connection = pymysql.connect(**config)

        print("   ✅ Conexión exitosa!")

        # Obtener información del servidor
        with connection.cursor() as cursor:
            cursor.execute("SELECT VERSION()")
            version = cursor.fetchone()[0]
            print(f"   ✅ Versión de MySQL: {version}")

            # Verificar base de datos actual
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
        print("✅ VERIFICACIÓN COMPLETA - Base de datos conectada correctamente")
        print("=" * 60)
        return True

    except pymysql.Error as e:
        print(f"\n❌ Error de conexión: {e}")
        error_code, error_msg = e.args
        print(f"   Código de error: {error_code}")
        print(f"   Mensaje: {error_msg}")

        # Sugerencias según el código de error
        if error_code == 2003:
            print("\n   💡 MySQL no está corriendo o no es accesible")
            print("      - Verifica que MySQL esté ejecutándose")
            print("      - Verifica el puerto (puede ser 3306 en lugar de 3307)")
        elif error_code == 1045:
            print("\n   💡 Credenciales incorrectas")
            print("      - Verifica usuario y contraseña")
        elif error_code == 1049:
            print("\n   💡 La base de datos no existe")
            print("      - Crea la base de datos: CREATE DATABASE coformacion1;")
        elif error_code == 2002:
            print("\n   💡 No se puede conectar al servidor MySQL")
            print("      - Verifica que MySQL esté corriendo")
            print("      - Verifica el host y puerto")

        return False

    except Exception as e:
        print(f"\n❌ Error inesperado: {e}")
        import traceback
        traceback.print_exc()
        return False

    finally:
        if connection:
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


