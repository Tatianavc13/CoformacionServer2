#!/bin/bash

echo "========================================"
echo "    INICIANDO PROYECTO COFORMACION"
echo "========================================"
echo ""
echo "Puerto Backend: 8001"
echo "Puerto Frontend: 4201"
echo "Puerto MySQL: 3306"
echo ""
echo "========================================"

# Verificar si MySQL está ejecutándose
echo "Verificando conexión a MySQL..."
if ! mysql -u root -p12345 -e "SELECT 1;" >/dev/null 2>&1; then
    echo "ERROR: No se puede conectar a MySQL"
    echo "Asegúrate de que MySQL esté ejecutándose en el puerto 3306"
    read -p "Presiona Enter para continuar..."
    exit 1
fi

# Verificar si la base de datos existe
echo "Verificando base de datos 'coformacion1'..."
if ! mysql -u root -p12345 -e "USE coformacion1;" >/dev/null 2>&1; then
    echo "Creando base de datos 'coformacion1'..."
    mysql -u root -p12345 -e "CREATE DATABASE IF NOT EXISTS coformacion1;"
    echo "Base de datos creada exitosamente"
fi

echo ""
echo "========================================"
echo "    INICIANDO BACKEND (PUERTO 8001)"
echo "========================================"
cd backendCoformacion
gnome-terminal --title="Backend Coformacion" -- bash -c "python manage.py runserver 127.0.0.1:8001; exec bash" &

echo ""
echo "========================================"
echo "    INICIANDO FRONTEND (PUERTO 4201)"
echo "========================================"
cd ..
gnome-terminal --title="Frontend Coformacion" -- bash -c "ng serve --port 4201; exec bash" &

echo ""
echo "========================================"
echo "    PROYECTO INICIADO EXITOSAMENTE"
echo "========================================"
echo ""
echo "Backend: http://localhost:8001"
echo "Frontend: http://localhost:4201"
echo "Admin Django: http://localhost:8001/admin"
echo ""
echo "Presiona Enter para cerrar esta ventana..."
read
