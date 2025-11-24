#!/usr/bin/env python
"""
Script para verificar en qué puerto está corriendo MySQL
"""

import socket

def check_port(host, port):
    """Verifica si un puerto está abierto"""
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.settimeout(2)
        result = sock.connect_ex((host, port))
        sock.close()
        return result == 0
    except Exception as e:
        return False

def main():
    print("=" * 60)
    print("VERIFICANDO PUERTO DE MYSQL")
    print("=" * 60)
    print()

    # Puertos comunes de MySQL
    puertos_comunes = [3007, 3306, 3307, 3308]

    print("Verificando puertos comunes de MySQL...")
    print()

    puertos_abiertos = []
    for puerto in puertos_comunes:
        if check_port('127.0.0.1', puerto):
            print(f"✅ Puerto {puerto} está ABIERTO y accesible")
            puertos_abiertos.append(puerto)
        else:
            print(f"❌ Puerto {puerto} está CERRADO o no accesible")

    print()
    print("=" * 60)

    if puertos_abiertos:
        print(f"✅ MySQL parece estar corriendo en: {', '.join(map(str, puertos_abiertos))}")
        print()
        print("💡 Actualiza settings.py con el puerto correcto:")
        print(f"   'PORT': '{puertos_abiertos[0]}',")
    else:
        print("❌ No se encontró MySQL en ningún puerto común")
        print()
        print("💡 Verifica que:")
        print("   1. MySQL esté instalado y corriendo")
        print("   2. El servicio MySQL esté iniciado")
        print("   3. El puerto no esté bloqueado por el firewall")

    print("=" * 60)

if __name__ == '__main__':
    main()


