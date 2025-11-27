import os
import django
import sys

# Setup Django environment
sys.path.append(os.path.join(os.path.dirname(__file__), 'backendCoformacion'))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'backend_uniempresarial.settings')
django.setup()

from django.db import connection

def fix_columns():
    print("Attempting to alter table columns...")
    with connection.cursor() as cursor:
        try:
            # Check current type (approximate check via trying to insert string)
            # Actually, just force alter.
            cursor.execute("ALTER TABLE contactos_de_emergencia MODIFY celular VARCHAR(20)")
            cursor.execute("ALTER TABLE contactos_de_emergencia MODIFY telefono VARCHAR(20)")
            print("Executed ALTER TABLE commands.")
            
            # Explicit commit just in case autocommit is off or something weird
            # connection.commit() # Django usually handles this in autocommit mode, but let's see.
            
        except Exception as e:
            print(f"Error altering table: {e}")

    # Verify
    print("\nVerifying columns via inspectdb logic...")
    with connection.cursor() as cursor:
        cursor.execute("DESCRIBE contactos_de_emergencia")
        rows = cursor.fetchall()
        for row in rows:
            if row[0] in ['celular', 'telefono']:
                print(f"Column: {row[0]}, Type: {row[1]}")

if __name__ == "__main__":
    fix_columns()
