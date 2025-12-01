from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('coformacion', '0007_add_ofrece_apoyo'),
    ]

    operations = [
        migrations.RunSQL(
            sql="""
            CREATE TABLE IF NOT EXISTS `proceso_coformacion` (
              `proceso_id` int NOT NULL AUTO_INCREMENT,
              `estudiante_id` int NOT NULL,
              `empresa_id` int NOT NULL,
              `oferta_id` int NOT NULL,
              `fecha_inicio` date NOT NULL,
              `fecha_fin` date DEFAULT NULL,
              `estado_id` int DEFAULT NULL,
              `observaciones` longtext,
              PRIMARY KEY (`proceso_id`),
              KEY `proceso_coformacion_estudiante_id_fk` (`estudiante_id`),
              KEY `proceso_coformacion_empresa_id_fk` (`empresa_id`),
              KEY `proceso_coformacion_oferta_id_fk` (`oferta_id`),
              KEY `proceso_coformacion_estado_id_fk` (`estado_id`),
              CONSTRAINT `proceso_coformacion_estudiante_id_fk` FOREIGN KEY (`estudiante_id`) REFERENCES `estudiantes` (`estudiante_id`),
              CONSTRAINT `proceso_coformacion_empresa_id_fk` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`empresa_id`),
              CONSTRAINT `proceso_coformacion_oferta_id_fk` FOREIGN KEY (`oferta_id`) REFERENCES `ofertasempresas` (`idOferta`),
              CONSTRAINT `proceso_coformacion_estado_id_fk` FOREIGN KEY (`estado_id`) REFERENCES `estados_proceso` (`estado_id`)
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
            """,
            reverse_sql="""
            DROP TABLE IF EXISTS `proceso_coformacion`;
            """,
        ),
    ]
