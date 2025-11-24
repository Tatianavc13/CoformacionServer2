@echo off
echo ========================================
echo    INICIANDO PROYECTO CON NGROK
echo ========================================
echo.
echo Este script iniciara:
echo - Backend Django en puerto 8000
echo - Frontend Angular en puerto 4201
echo - ngrok para acceso publico
echo.
echo ========================================
echo.

REM Verificar si ngrok esta instalado
where ngrok >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] ngrok no esta instalado o no esta en el PATH
    echo.
    echo Instala ngrok desde: https://ngrok.com/download
    echo O agrega ngrok al PATH de Windows
    echo.
    pause
    exit /b 1
)

echo [INFO] Iniciando Backend Django...
cd backendCoformacion
start "Django Backend" cmd /k "venv\Scripts\activate && python manage.py runserver 0.0.0.0:8000"

REM Esperar un poco para que Django se inicie
timeout /t 3 /nobreak >nul

echo [INFO] Iniciando Frontend Angular...
cd ..
start "Angular Frontend" cmd /k "ng serve --host 0.0.0.0 --port 4201"

REM Esperar un poco para que Angular se inicie
timeout /t 5 /nobreak >nul

echo [INFO] Iniciando ngrok para Frontend (puerto 4201)...
start "ngrok Frontend" cmd /k "ngrok http 4201"

echo.
echo [INFO] Para exponer el Backend tambien, ejecuta en otra terminal:
echo        ngrok http 8000
echo.
echo ========================================
echo    SERVICIOS INICIADOS
echo ========================================
echo.
echo Backend local:  http://127.0.0.1:8000
echo Frontend local: http://localhost:4201
echo.
echo Revisa la ventana de ngrok para obtener la URL publica
echo.
echo Presiona cualquier tecla para cerrar esta ventana...
pause >nul


