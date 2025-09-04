# Generated manually for updating OfertasEmpresas model

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('coformacion', '0002_empresas_actividad_economica_empresas_ciudad_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='ofertasempresas',
            name='programa_id',
            field=models.ForeignKey(blank=True, db_column='programa_id', null=True, on_delete=django.db.models.deletion.SET_NULL, to='coformacion.programas'),
        ),
        migrations.AddField(
            model_name='ofertasempresas',
            name='tipo_oferta',
            field=models.CharField(blank=True, choices=[('Nacional', 'Nacional'), ('Internacional', 'Internacional')], max_length=20, null=True),
        ),
        migrations.AddField(
            model_name='ofertasempresas',
            name='apoyo_economico',
            field=models.CharField(blank=True, choices=[('Si', 'Si'), ('No', 'No')], max_length=2, null=True),
        ),
        migrations.AddField(
            model_name='ofertasempresas',
            name='nombre_responsable',
            field=models.CharField(blank=True, max_length=255, null=True),
        ),
        migrations.AddField(
            model_name='ofertasempresas',
            name='modalidad',
            field=models.CharField(blank=True, choices=[('Presencial', 'Presencial'), ('Virtual', 'Virtual'), ('Híbrido', 'Híbrido')], max_length=10, null=True),
        ),
    ] 