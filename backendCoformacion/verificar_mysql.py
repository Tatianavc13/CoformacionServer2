#!/usr/bin/env python
"""
Script para verificar si MySQL está accesible antes de intentar conectarse
"""

import socket
import subprocess
import sys

def check_mysql_port(host='127.0.0.1', port=3307):
    """Verifica si el puerto de MySQL está abierto"""
    print(f"Verificando si MySQL está escuchando en {host}:{port}...")
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.settimeout(2)
        result = sock.connect_ex((host, port))
        sock.close()

        if result == 0:
            print(f"✅ El puerto {port} está abierto y accesible")
            return True
        else:
            print(f"❌ El puerto {port} no está accesible (código: {result})")
            return False
    except Exception as e:
        print(f"❌ Error al verificar el puerto: {e}")
        return False

def check_mysql_service():
    """Verifica si el servicio MySQL está corriendo (Windows)"""
    print("\nVerificando servicios de MySQL...")
    try:
        result = subprocess.run(
            ['powershell', '-Command', "Get-Service | Where-Object {$_.Name -like '*mysql*'} | Select-Object Name, Status"],
            capture_output=True,
            text=True,
            timeout=5
        )
        if result.returncode == 0 and result.stdout.strip():
            print("Servicios MySQL encontrados:")
            print(result.stdout)
            return True
        else:
            print("⚠️  No se encontraron servicios MySQL con ese nombre")
            print("   (Esto no significa que MySQL no esté corriendo)")
            return False
    except Exception as e:
        print(f"⚠️  No se pudo verificar servicios: {e}")
        return False

def test_mysql_command():
    """Intenta ejecutar un comando MySQL simple"""
    print("\nIntentando ejecutar comando MySQL...")
    try:
        # Intentar con puerto 3307
        result = subprocess.run(
            ['mysql', '-u', 'root', '-h', '127.0.0.1', '-P', '3307', '-e', 'SELECT 1'],
            capture_output=True,
            text=True,
            timeout=5
        )

        if result.returncode == 0:
            print("✅ Comando MySQL ejecutado exitosamente")
            return True
        else:
            print(f"❌ Error al ejecutar MySQL: {result.stderr}")
            return False
    except FileNotFoundError:
        print("⚠️  El comando 'mysql' no está en el PATH")
        print("   Esto es normal si MySQL no está en las variables de entorno")
        return None
    except Exception as e:
        print(f"❌ Error: {e}")
        return False

def main():
    print("=" * 60)
    print("VERIFICACIÓN DE ACCESIBILIDAD DE MYSQL")
    print("=" * 60)

    # Verificar puerto
    port_ok = check_mysql_port('127.0.0.1', 3307)

    # Si el puerto 3307 no está disponible, probar 3306
    if not port_ok:
        print("\n⚠️  El puerto 3307 no está disponible. Probando puerto 3306...")
        port_ok_3306 = check_mysql_port('127.0.0.1', 3306)
        if port_ok_3306:
            print("\n💡 MySQL parece estar en el puerto 3306, no en 3307")
            print("   Considera cambiar el puerto en settings.py a 3306")

    # Verificar servicios (Windows)
    check_mysql_service()

    # Intentar comando MySQL
    mysql_cmd = test_mysql_command()

    print("\n" + "=" * 60)
    if port_ok:
        print("✅ MySQL parece estar accesible en el puerto configurado")
    else:
        print("❌ MySQL no está accesible en el puerto configurado")
        print("\nSiguientes pasos:")
        print("1. Verifica que MySQL esté instalado y corriendo")
        print("2. Verifica el puerto correcto (puede ser 3306 en lugar de 3307)")
        print("3. Verifica que no haya un firewall bloqueando la conexión")
    print("=" * 60)

if __name__ == '__main__':
    main()


