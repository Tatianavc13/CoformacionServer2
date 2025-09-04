@echo off
echo Aplicando migraciones a la base de datos...
cd backendCoformacion
python manage.py makemigrations
python manage.py migrate
echo Migraciones aplicadas exitosamente!
pause 