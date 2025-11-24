# Generated manually for adding descripcion, fecha_inicio, fecha_fin to OfertasEmpresas

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('coformacion', '0005_add_logo_url_to_empresas'),
    ]

    operations = [
        migrations.AddField(
            model_name='ofertasempresas',
            name='descripcion',
            field=models.TextField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='ofertasempresas',
            name='fecha_inicio',
            field=models.DateField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='ofertasempresas',
            name='fecha_fin',
            field=models.DateField(blank=True, null=True),
        ),
        # Hacer los campos antiguos opcionales para compatibilidad
        migrations.AlterField(
            model_name='ofertasempresas',
            name='nacional',
            field=models.CharField(blank=True, choices=[('No', 'No'), ('Si', 'Si')], max_length=2, null=True),
        ),
        migrations.AlterField(
            model_name='ofertasempresas',
            name='nombreTutor',
            field=models.CharField(blank=True, max_length=40, null=True),
        ),
        migrations.AlterField(
            model_name='ofertasempresas',
            name='apoyoEconomico',
            field=models.DecimalField(blank=True, db_column='apoyoEconomico', decimal_places=2, max_digits=10, null=True),
        ),
        migrations.AlterField(
            model_name='ofertasempresas',
            name='modalidad',
            field=models.CharField(blank=True, choices=[('Presencial', 'Presencial'), ('Virtual', 'Virtual'), ('Híbrido', 'Híbrido')], max_length=10, null=True),
        ),
        migrations.AlterField(
            model_name='ofertasempresas',
            name='nombreEmpresa',
            field=models.CharField(blank=True, max_length=255, null=True),
        ),
    ]

