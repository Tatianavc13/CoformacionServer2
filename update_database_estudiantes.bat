@echo off
echo ===============================================
echo    ACTUALIZACION DE BASE DE DATOS - ESTUDIANTES
echo ===============================================
echo.
echo Este script agregara estudiantes de prueba para
echo mejorar el sistema de recomendaciones.
echo.
echo Asegurese de que:
echo 1. MySQL este ejecutandose
echo 2. Tenga las credenciales correctas
echo 3. La base de datos exista
echo.
pause

echo.
echo Ejecutando script SQL...
mysql -u root -p coformacion1 < backendCoformacion\agregar_estudiantes_prueba.sql

if %ERRORLEVEL% == 0 (
    echo.
    echo ===============================================
    echo   EXITO: Estudiantes agregados correctamente
    echo ===============================================
    echo.
    echo Ahora puede probar el sistema de recomendaciones
    echo con multiples estudiantes.
    echo.
    echo Recuerde reiniciar el backend si es necesario:
    echo   cd backendCoformacion
    echo   python manage.py runserver
) else (
    echo.
    echo ===============================================
    echo   ERROR: Hubo un problema al ejecutar el SQL
    echo ===============================================
    echo.
    echo Verifique:
    echo - Credenciales de MySQL
    echo - Nombre de la base de datos
    echo - Permisos de usuario
)

echo.
pause
