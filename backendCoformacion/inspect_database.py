#!/usr/bin/env python
"""
Script para inspeccionar la estructura de la base de datos MySQL
y compararla con los modelos de Django.
"""

import os
import sys
import django

# Configurar Django
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'backend_uniempresarial.settings')
django.setup()

from django.db import connection
from django.apps import apps

def get_database_tables():
    """Obtiene todas las tablas de la base de datos"""
    with connection.cursor() as cursor:
        cursor.execute("SHOW TABLES")
        tables = [row[0] for row in cursor.fetchall()]
        # Filtrar tablas de Django
        django_tables = ['django_migrations', 'django_content_type', 'django_admin_log', 
                        'django_session', 'auth_group', 'auth_permission', 'auth_user',
                        'auth_group_permissions', 'auth_user_groups', 'auth_user_user_permissions']
        return [t for t in tables if t not in django_tables]

def get_table_structure(table_name):
    """Obtiene la estructura de una tabla"""
    with connection.cursor() as cursor:
        cursor.execute(f"DESCRIBE `{table_name}`")
        columns = cursor.fetchall()
        return columns

def get_django_models():
    """Obtiene todos los modelos de Django de la app coformacion"""
    models = {}
    for model in apps.get_app_config('coformacion').get_models():
        models[model._meta.db_table] = model
    return models

def compare_database_and_models():
    """Compara la base de datos con los modelos de Django"""
    print("=" * 80)
    print("INSPECCIÓN DE BASE DE DATOS Y MODELOS DE DJANGO")
    print("=" * 80)
    
    # Obtener tablas de la base de datos
    db_tables = get_database_tables()
    print(f"\n📊 Tablas encontradas en la base de datos: {len(db_tables)}")
    for table in sorted(db_tables):
        print(f"   - {table}")
    
    # Obtener modelos de Django
    django_models = get_django_models()
    print(f"\n📋 Modelos encontrados en Django: {len(django_models)}")
    for table_name in sorted(django_models.keys()):
        print(f"   - {table_name}")
    
    # Comparar
    print("\n" + "=" * 80)
    print("COMPARACIÓN")
    print("=" * 80)
    
    # Tablas en BD pero no en Django
    tables_only_in_db = set(db_tables) - set(django_models.keys())
    if tables_only_in_db:
        print(f"\n⚠️  Tablas en BD que NO están en Django ({len(tables_only_in_db)}):")
        for table in sorted(tables_only_in_db):
            print(f"\n   📌 Tabla: {table}")
            columns = get_table_structure(table)
            print(f"      Columnas ({len(columns)}):")
            for col in columns:
                field_name, field_type, null, key, default, extra = col
                null_str = "NULL" if null == "YES" else "NOT NULL"
                key_str = f" [{key}]" if key else ""
                print(f"         - {field_name}: {field_type} {null_str}{key_str}")
    
    # Tablas en Django pero no en BD
    tables_only_in_django = set(django_models.keys()) - set(db_tables)
    if tables_only_in_django:
        print(f"\n⚠️  Tablas en Django que NO están en BD ({len(tables_only_in_django)}):")
        for table in sorted(tables_only_in_django):
            print(f"   - {table}")
    
    # Comparar columnas de tablas existentes
    print(f"\n🔍 Comparando columnas de tablas existentes...")
    common_tables = set(db_tables) & set(django_models.keys())
    
    differences_found = False
    for table_name in sorted(common_tables):
        db_columns = {col[0]: col for col in get_table_structure(table_name)}
        model = django_models[table_name]
        model_fields = {field.db_column or field.name: field for field in model._meta.get_fields() 
                       if hasattr(field, 'db_column') or hasattr(field, 'column')}
        
        # Columnas en BD pero no en modelo
        db_col_names = set(db_columns.keys())
        model_col_names = set(model_fields.keys())
        
        missing_in_model = db_col_names - model_col_names
        missing_in_db = model_col_names - db_col_names
        
        if missing_in_model or missing_in_db:
            differences_found = True
            print(f"\n   📌 Tabla: {table_name}")
            
            if missing_in_model:
                print(f"      ⚠️  Columnas en BD que NO están en el modelo ({len(missing_in_model)}):")
                for col_name in sorted(missing_in_model):
                    col_info = db_columns[col_name]
                    field_type = col_info[1]
                    null = col_info[2]
                    print(f"         - {col_name}: {field_type} ({'NULL' if null == 'YES' else 'NOT NULL'})")
            
            if missing_in_db:
                print(f"      ⚠️  Columnas en modelo que NO están en BD ({len(missing_in_db)}):")
                for col_name in sorted(missing_in_db):
                    field = model_fields[col_name]
                    print(f"         - {col_name}: {type(field).__name__}")
    
    if not differences_found and not tables_only_in_db:
        print("\n✅ No se encontraron diferencias. La base de datos y los modelos están sincronizados.")
    else:
        print("\n" + "=" * 80)
        print("RESUMEN")
        print("=" * 80)
        print(f"Tablas nuevas en BD: {len(tables_only_in_db)}")
        print(f"Tablas faltantes en BD: {len(tables_only_in_django)}")
        if differences_found:
            print("Diferencias en columnas encontradas (ver detalles arriba)")

if __name__ == '__main__':
    try:
        compare_database_and_models()
    except Exception as e:
        print(f"\n❌ Error: {e}")
        import traceback
        traceback.print_exc()

