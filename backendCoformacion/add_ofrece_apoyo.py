import os
import django


def main():
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'backend_uniempresarial.settings')
    django.setup()
    from django.db import connection
    sql = "ALTER TABLE `ofertasempresas` ADD COLUMN IF NOT EXISTS `Ofrece_apoyo` varchar(3) DEFAULT 'No';"
    try:
        with connection.cursor() as cursor:
            cursor.execute(sql)
        print('Columna `Ofrece_apoyo` añadida (si no existía).')
    except Exception as e:
        print('Error al añadir columna:', e)


if __name__ == '__main__':
    main()
