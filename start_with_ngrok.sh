#!/bin/bash

echo "========================================"
echo "   INICIANDO PROYECTO CON NGROK"
echo "========================================"
echo ""
echo "Este script iniciará:"
echo "- Backend Django en puerto 8000"
echo "- Frontend Angular en puerto 4201"
echo "- ngrok para acceso público"
echo ""
echo "========================================"
echo ""

# Verificar si ngrok está instalado
if ! command -v ngrok &> /dev/null; then
    echo "[ERROR] ngrok no está instalado o no está en el PATH"
    echo ""
    echo "Instala ngrok desde: https://ngrok.com/download"
    echo "O agrega ngrok al PATH"
    echo ""
    exit 1
fi

echo "[INFO] Iniciando Backend Django..."
cd backendCoformacion
source venv/bin/activate
python manage.py runserver 0.0.0.0:8000 &
DJANGO_PID=$!
cd ..

# Esperar un poco para que Django se inicie
sleep 3

echo "[INFO] Iniciando Frontend Angular..."
ng serve --host 0.0.0.0 --port 4201 &
ANGULAR_PID=$!

# Esperar un poco para que Angular se inicie
sleep 5

echo "[INFO] Iniciando ngrok para Frontend (puerto 4201)..."
ngrok http 4201 &
NGROK_PID=$!

echo ""
echo "[INFO] Para exponer el Backend también, ejecuta en otra terminal:"
echo "       ngrok http 8000"
echo ""
echo "========================================"
echo "   SERVICIOS INICIADOS"
echo "========================================"
echo ""
echo "Backend local:  http://127.0.0.1:8000"
echo "Frontend local: http://localhost:4201"
echo ""
echo "Revisa la ventana de ngrok para obtener la URL pública"
echo ""
echo "Presiona Ctrl+C para detener todos los servicios..."

# Esperar a que el usuario presione Ctrl+C
trap "kill $DJANGO_PID $ANGULAR_PID $NGROK_PID 2>/dev/null; exit" INT
wait


