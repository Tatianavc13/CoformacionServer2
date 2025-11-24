# Generated manually

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('coformacion', '0004_alter_ofertasempresas_apoyo_economico_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='empresas',
            name='logo_url',
            field=models.CharField(blank=True, max_length=255, null=True, db_column='logo_url'),
        ),
    ]


