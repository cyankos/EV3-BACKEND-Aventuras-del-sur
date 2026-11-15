"""
Backend de compatibilidad para el XAMPP del laboratorio (MariaDB 10.4.x).

Django 5.2.8 soporta Python 3.14, pero su backend MySQL oficial exige
MariaDB >= 10.5. Para este proyecto académico se hereda el backend MySQL
y se conserva la detección de capacidades de Django, relajando únicamente
el chequeo mínimo a MariaDB 10.4.

El proyecto usa operaciones CRUD/ForeignKey/consultas básicas compatibles
con MariaDB 10.4.
"""
from django.db.backends.mysql.base import DatabaseWrapper as MySQLDatabaseWrapper
from django.db.backends.mysql.features import DatabaseFeatures as MySQLDatabaseFeatures
from django.utils.functional import cached_property


class DatabaseFeatures(MySQLDatabaseFeatures):
    can_return_columns_from_insert = False
    can_return_rows_from_bulk_insert = False

    @cached_property
    def minimum_database_version(self):
        if self.connection.mysql_is_mariadb:
            return (10, 4)
        return (8, 0, 11)


class DatabaseWrapper(MySQLDatabaseWrapper):
    features_class = DatabaseFeatures