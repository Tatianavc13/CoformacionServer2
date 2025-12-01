from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('coformacion', '0006_add_descripcion_fechas_to_ofertas'),
    ]

    operations = [
        # Añadir la columna `Ofrece_apoyo` si no existe para mantener la compatibilidad
        migrations.RunSQL(
            sql="""
            ALTER TABLE `ofertasempresas`
            ADD COLUMN IF NOT EXISTS `Ofrece_apoyo` varchar(3) DEFAULT 'No';
            """,
            reverse_sql="""
            ALTER TABLE `ofertasempresas`
            DROP COLUMN IF EXISTS `Ofrece_apoyo`;
            """,
        ),
    ]
