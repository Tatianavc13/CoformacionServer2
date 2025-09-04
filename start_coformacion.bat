@echo off
echo ========================================
echo    INICIANDO PROYECTO COFORMACION
echo ========================================
echo.
echo Puerto Backend: 8001
echo Puerto Frontend: 4201
echo Puerto MySQL: 3306
echo.
echo ========================================

REM Verificar si MySQL está ejecutándose
echo Verificando conexión a MySQL...
mysql -u root -p12345 -e "SELECT 1;" >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: No se puede conectar a MySQL
    echo Asegúrate de que MySQL esté ejecutándose en el puerto 3306
    pause
    exit /b 1
)

REM Verificar si la base de datos existe
echo Verificando base de datos 'coformacion1'...
mysql -u root -p12345 -e "USE coformacion1;" >nul 2>&1
if %errorlevel% neq 0 (
    echo Creando base de datos 'coformacion1'...
    mysql -u root -p12345 -e "CREATE DATABASE IF NOT EXISTS coformacion1;"
    echo Base de datos creada exitosamente
)

echo.
echo ========================================
echo    INICIANDO BACKEND (PUERTO 8001)
echo ========================================
cd backendCoformacion
start "Backend Coformacion" cmd /k "py manage.py runserver 127.0.0.1:8001"

echo.
echo ========================================
echo    INICIANDO FRONTEND (PUERTO 4201)
echo ========================================
cd ..
start "Frontend Coformacion" cmd /k "ng serve --port 4201"

echo.
echo ========================================
echo    PROYECTO INICIADO EXITOSAMENTE
echo ========================================
echo.
echo Backend: http://localhost:8001
echo Frontend: http://localhost:4201
echo Admin Django: http://localhost:8001/admin
echo.
echo Presiona cualquier tecla para cerrar esta ventana...
pause >nul
