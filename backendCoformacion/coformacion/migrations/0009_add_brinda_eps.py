from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('coformacion', '0008_create_proceso_coformacion'),
    ]

    operations = [
        # Añadir la columna `brinda_eps` si no existe para mantener la compatibilidad
        migrations.RunSQL(
            sql="""
            ALTER TABLE `ofertasempresas`
            ADD COLUMN IF NOT EXISTS `brinda_eps` varchar(3) DEFAULT 'No';
            """,
            reverse_sql="""
            ALTER TABLE `ofertasempresas`
            DROP COLUMN IF EXISTS `brinda_eps`;
            """,
        ),
    ]
