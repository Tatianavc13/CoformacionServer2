# Generated manually to sync models with existing database structure

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('coformacion', '0009_add_brinda_eps'),
    ]

    operations = [
        # Nuevos modelos
        migrations.CreateModel(
            name='Docentes',
            fields=[
                ('docente_id', models.AutoField(primary_key=True, serialize=False)),
                ('nombre_completo_docente', models.CharField(max_length=255)),
                ('cargo_docente', models.CharField(max_length=255)),
                ('telefono_docente', models.CharField(blank=True, max_length=20, null=True)),
                ('email_docente', models.CharField(blank=True, max_length=255, null=True)),
            ],
            options={
                'db_table': 'docentes',
            },
        ),
        migrations.CreateModel(
            name='CortesCoformacion',
            fields=[
                ('corte_id', models.AutoField(primary_key=True, serialize=False)),
                ('numero_corte', models.CharField(max_length=255)),
                ('fecha_inicio_corte', models.DateField()),
                ('fecha_finalizacion_corte', models.DateField()),
            ],
            options={
                'db_table': 'cortes_coformacion',
            },
        ),
        migrations.CreateModel(
            name='ProcesosCoformacion',
            fields=[
                ('proceso_id', models.AutoField(primary_key=True, serialize=False)),
                ('fecha_inicio_fase_coformacion', models.DateField()),
                ('fecha_fin_fase_practica', models.DateField(blank=True, null=True)),
                ('fecha_ingreso_empresa', models.DateField(blank=True, null=True)),
                ('fecha_finalizacion_empresa', models.DateField(blank=True, null=True)),
                ('fecha_carta_presentacion', models.DateField(blank=True, null=True)),
                ('horario', models.TextField(blank=True, null=True)),
                ('forma_de_pago', models.DecimalField(blank=True, decimal_places=2, max_digits=10, null=True)),
                ('trabaja_sabado', models.BooleanField(blank=True, null=True)),
                ('salario', models.DecimalField(blank=True, decimal_places=2, max_digits=10, null=True)),
                ('modalidad_vinculacion', models.CharField(choices=[('Presencial', 'Presencial'), ('Virtual', 'Virtual'), ('Híbrido', 'Híbrido')], max_length=10)),
                ('carta_presentacion_enviada', models.CharField(choices=[('Si', 'Si'), ('No', 'No')], max_length=2)),
                ('carta_presentacion_recibida', models.CharField(choices=[('Si', 'Si'), ('No', 'No')], max_length=2)),
                ('modalidad_coformacion', models.CharField(choices=[('Presencial', 'Presencial'), ('Virtual', 'Virtual'), ('Híbrido', 'Híbrido')], max_length=10)),
                ('observaciones', models.TextField(blank=True, null=True)),
                ('fecha_creacion', models.DateTimeField(blank=True, null=True)),
                ('fecha_actualizacion', models.DateTimeField(blank=True, null=True)),
                ('empresa', models.ForeignKey(db_column='empresa_id', on_delete=django.db.models.deletion.CASCADE, to='coformacion.empresas')),
                ('estado', models.ForeignKey(db_column='estado_id', on_delete=django.db.models.deletion.RESTRICT, to='coformacion.estadoproceso')),
                ('estudiante', models.ForeignKey(db_column='estudiante_id', on_delete=django.db.models.deletion.CASCADE, to='coformacion.estudiantes')),
            ],
            options={
                'db_table': 'procesos_coformacion',
            },
        ),
        migrations.CreateModel(
            name='AcompanamientoEstudiantilCoformacion',
            fields=[
                ('acompanamiento_id', models.AutoField(db_column='acompanamiento_id', primary_key=True, serialize=False)),
                ('nombre_tutor_empresa', models.CharField(blank=True, max_length=255, null=True)),
                ('cargo_tutor_empresa', models.CharField(blank=True, max_length=255, null=True)),
                ('telefono_tutor_empresa', models.CharField(blank=True, max_length=20, null=True)),
                ('email_tutor_empresa', models.CharField(blank=True, max_length=255, null=True)),
                ('corte', models.ForeignKey(blank=True, db_column='corte_id', null=True, on_delete=django.db.models.deletion.SET_NULL, to='coformacion.cortescoformacion')),
                ('docente', models.ForeignKey(blank=True, db_column='docente_id', null=True, on_delete=django.db.models.deletion.SET_NULL, to='coformacion.docentes')),
                ('empresa', models.ForeignKey(blank=True, db_column='empresa_id', null=True, on_delete=django.db.models.deletion.SET_NULL, to='coformacion.empresas')),
                ('estudiante', models.ForeignKey(db_column='estudiante_id', on_delete=django.db.models.deletion.CASCADE, to='coformacion.estudiantes')),
                ('proceso', models.ForeignKey(blank=True, db_column='proceso_id', null=True, on_delete=django.db.models.deletion.SET_NULL, to='coformacion.procesoscoformacion')),
            ],
            options={
                'db_table': 'acompañamiento_estudiantil_coformacion',
            },
        ),
        # Actualizar modelos existentes - usar RunSQL para evitar conflictos con datos existentes
        migrations.RunSQL(
            sql="",
            reverse_sql="",
        ),
    ]

