-- Script corregido para agregar estudiantes de prueba
-- Estructura actualizada para la tabla estudiantes

INSERT INTO `estudiantes` (
    `codigo_estudiante`, `nombre_completo`, `tipo_documento`, `numero_documento`, 
    `fecha_nacimiento`, `genero`, `telefono`, `celular`, `email_institucional`, 
    `email_personal`, `direccion`, `ciudad`, `foto_url`, `semestre`, `jornada`, 
    `promedio_acumulado`, `estado`, `fecha_ingreso`, `fecha_creacion`, 
    `fecha_actualizacion`, `empresa_id`, `estado_cartera_id`, `nivel_ingles_id`, 
    `programa_id`, `promocion_id`
) VALUES 
('002', 'María González', 'CC', '1234567891', '2003-08-22', 'F', '3112345678', '3112345678', 
 'mgonzalez@uniempresarial.edu.co', 'maria.gonzalez@gmail.com', 'Carrera 15 #85-40', 'Bogotá', 
 '', 4, 'Diurna', 4.5, 'Activo', '2022-02-01', NOW(), NOW(), NULL, 1, 2, 1, 1),

('003', 'Carlos Rodríguez', 'CC', '1234567892', '2002-11-15', 'M', '3223456789', '3223456789', 
 'crodriguez@uniempresarial.edu.co', 'carlos.rodriguez@gmail.com', 'Calle 72 #10-20', 'Bogotá', 
 '', 6, 'Diurna', 4.2, 'Activo', '2021-08-01', NOW(), NOW(), NULL, 1, 3, 2, 1),

('004', 'Ana Martínez', 'CC', '1234567893', '2004-03-10', 'F', '3334567890', '3334567890', 
 'amartinez@uniempresarial.edu.co', 'ana.martinez@gmail.com', 'Avenida 68 #45-12', 'Bogotá', 
 '', 3, 'Nocturna', 4.0, 'Activo', '2023-02-01', NOW(), NOW(), NULL, 2, 1, 3, 2),

('005', 'Luis Hernández', 'CC', '1234567894', '2003-07-18', 'M', '3445678901', '3445678901', 
 'lhernandez@uniempresarial.edu.co', 'luis.hernandez@gmail.com', 'Transversal 45 #123-67', 'Bogotá', 
 '', 5, 'Diurna', 3.8, 'Activo', '2022-08-01', NOW(), NOW(), NULL, 1, 2, 1, 2),

('006', 'Isabella Torres', 'CC', '1234567895', '2004-01-25', 'F', '3556789012', '3556789012', 
 'itorres@uniempresarial.edu.co', 'isabella.torres@gmail.com', 'Diagonal 56 #78-90', 'Bogotá', 
 '', 4, 'Diurna', 4.3, 'Activo', '2023-02-01', NOW(), NOW(), NULL, 1, 3, 2, 1),

('007', 'Sebastián Vargas', 'CC', '1234567896', '2003-12-08', 'M', '3667890123', '3667890123', 
 'svargas@uniempresarial.edu.co', 'sebastian.vargas@gmail.com', 'Calle 134 #15-28', 'Bogotá', 
 '', 2, 'Diurna', 3.9, 'Activo', '2024-02-01', NOW(), NOW(), NULL, 1, 1, 3, 2),

('008', 'Camila Jiménez', 'CC', '1234567897', '2004-05-14', 'F', '3778901234', '3778901234', 
 'cjimenez@uniempresarial.edu.co', 'camila.jimenez@gmail.com', 'Carrera 30 #67-89', 'Bogotá', 
 '', 3, 'Nocturna', 4.1, 'Activo', '2024-02-01', NOW(), NOW(), NULL, 2, 2, 1, 1),

('009', 'Andrés Morales', 'CC', '1234567898', '2003-09-30', 'M', '3889012345', '3889012345', 
 'amorales@uniempresarial.edu.co', 'andres.morales@gmail.com', 'Avenida 39 #12-34', 'Bogotá', 
 '', 7, 'Diurna', 4.4, 'Activo', '2021-02-01', NOW(), NOW(), NULL, 1, 3, 2, 2),

('010', 'Valentina Castro', 'CC', '1234567899', '2004-04-12', 'F', '3990123456', '3990123456', 
 'vcastro@uniempresarial.edu.co', 'valentina.castro@gmail.com', 'Calle 80 #25-50', 'Bogotá', 
 '', 2, 'Diurna', 3.7, 'Activo', '2024-08-01', NOW(), NOW(), NULL, 1, 1, 3, 1);

-- Verificar que se insertaron correctamente
SELECT COUNT(*) as total_estudiantes FROM estudiantes;
SELECT programa_id, COUNT(*) as estudiantes_por_programa FROM estudiantes GROUP BY programa_id;
