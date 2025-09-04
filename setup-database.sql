-- Script de configuración de base de datos para conformacion.twentybyte.com
-- Base de datos: coformacion1
-- Usuario: coformacion_user
-- Contraseña: Coformacion2024#Secure
-- Puerto: 3306 (MySQL existente)

-- Crear base de datos
CREATE DATABASE IF NOT EXISTS coformacion1 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- Crear usuario específico para el proyecto
CREATE USER IF NOT EXISTS 'coformacion_user'@'localhost' 
IDENTIFIED BY 'Coformacion2024#Secure';

-- Otorgar privilegios completos sobre la base de datos
GRANT ALL PRIVILEGES ON coformacion1.* 
TO 'coformacion_user'@'localhost';

-- Aplicar cambios de privilegios
FLUSH PRIVILEGES;

-- Verificar creación
SELECT 'Base de datos coformacion1 creada exitosamente' as status;
SELECT 'Usuario coformacion_user creado exitosamente' as status;

-- Mostrar información de la base de datos
SHOW DATABASES LIKE 'coformacion1';
SELECT User, Host FROM mysql.user WHERE User = 'coformacion_user';
