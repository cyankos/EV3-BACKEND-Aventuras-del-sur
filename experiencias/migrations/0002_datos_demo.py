from datetime import timedelta
from decimal import Decimal

from django.contrib.auth.hashers import make_password
from django.db import migrations
from django.utils import timezone


def cargar_datos(apps, schema_editor):
    Usuario = apps.get_model('cuentas', 'Usuario')
    Categoria = apps.get_model('experiencias', 'Categoria')
    Experiencia = apps.get_model('experiencias', 'Experiencia')
    Reserva = apps.get_model('experiencias', 'Reserva')

    def usuario(username, first_name, last_name, rol, password, admin=False):
        obj, _ = Usuario.objects.update_or_create(
            username=username,
            defaults={
                'first_name': first_name,
                'last_name': last_name,
                'email': f'{username}@aventurasdelsur.cl',
                'rol': rol,
                'is_active': True,
                'is_staff': admin,
                'is_superuser': admin,
                'password': make_password(password),
            },
        )
        return obj

    admin = usuario('admin', 'Rodrigo', 'Sanchez', 'admin', 'Admin123!', True)
    guia1 = usuario('guia1', 'Nicolás', 'Sánchez', 'guia', 'Guia123!')
    guia2 = usuario('guia2', 'Fernanda', 'Gómez', 'guia', 'Guia123!')
    turista1 = usuario('turista1', 'Diego', 'Perez', 'turista', 'Turista123!')
    turista2 = usuario('turista2', 'Camila', 'Navarro', 'turista', 'Turista123!')

    categorias = {}
    for nombre, descripcion in [
        ('Trekking', 'Caminatas guiadas por senderos volcánicos, bosques de araucarias y lagunas.'),
        ('Canopy', 'Circuitos de tirolesas y puentes colgantes entre bosque nativo.'),
        ('Kayak', 'Travesías guiadas en aguas tranquilas de lagos y ríos del sector.'),
        ('Arriendo de equipos', 'Equipamiento de montaña, bastones, carpas y accesorios por jornada.'),
    ]:
        cat, _ = Categoria.objects.update_or_create(
            nombre=nombre,
            defaults={'descripcion': descripcion, 'activo': True},
        )
        categorias[nombre] = cat

    ahora = timezone.now()
    datos = [
        (guia1, 'Trekking Los Lagos (Huerquehue)', 'Recorrido de jornada completa por lagunas Verde, Chico y Toro entre araucarias.', 'Trekking', 22000, 14, 6),
        (guia1, 'Canopy Río Trancura', 'Circuito de 7 líneas de tirolesa sobre bosque nativo con vista al volcán Villarrica.', 'Canopy', 28000, 12, 9),
        (guia1, 'Kayak Bahía La Poza', 'Travesía matinal en kayak doble por la ribera del lago Villarrica con equipo incluido.', 'Kayak', 20000, 10, 12),
        (guia1, 'Set Bastones + Mochila 30L', 'Arriendo diario de par de bastones telescópicos de aluminio y mochila impermeable.', 'Arriendo de equipos', 10000, 20, 4),
        (guia2, 'Ascenso Mirador El Cañi', 'Caminata guiada hacia el mirador panorámico con vista a los volcanes de la zona.', 'Trekking', 25000, 12, 8),
        (guia2, 'Canopy Bosque de Coihues', 'Tramo familiar de baja altura con plataformas panorámicas e instrucción previa.', 'Canopy', 24000, 15, 14),
        (guia2, 'Kayak Laguna Tinquilco', 'Remada tranquila en aguas cristalinas rodeadas de bosque nativo.', 'Kayak', 23000, 10, 11),
        (guia2, 'Kit Camping Alta Montaña (2P)', 'Incluye carpa 4 estaciones, dos sacos de dormir térmicos y colchonetas aislantes.', 'Arriendo de equipos', 32000, 8, 5),
    ]

    experiencias = {}
    for creador, titulo, desc, cat, precio, cupo, dias in datos:
        exp, _ = Experiencia.objects.update_or_create(
            titulo=titulo,
            creador=creador,
            defaults={
                'descripcion': desc,
                'categoria': categorias[cat],
                'precio': Decimal(str(precio)),
                'cupo_maximo': cupo,
                'fecha_hora': ahora + timedelta(days=dias),
            },
        )
        experiencias[titulo] = exp

    reservas = [
        (turista1, 'Trekking Los Lagos (Huerquehue)', 'confirmado'),
        (turista1, 'Canopy Río Trancura', 'pendiente'),
        (turista1, 'Kayak Laguna Tinquilco', 'confirmado'),
        (turista2, 'Ascenso Mirador El Cañi', 'confirmado'),
        (turista2, 'Kayak Bahía La Poza', 'pendiente'),
        (turista2, 'Kit Camping Alta Montaña (2P)', 'confirmado'),
    ]
    for turista, titulo, estado in reservas:
        Reserva.objects.update_or_create(
            usuario=turista,
            experiencia=experiencias[titulo],
            defaults={'estado_pago': estado},
        )


def borrar_datos(apps, schema_editor):
    Reserva = apps.get_model('experiencias', 'Reserva')
    Experiencia = apps.get_model('experiencias', 'Experiencia')
    Categoria = apps.get_model('experiencias', 'Categoria')
    Usuario = apps.get_model('cuentas', 'Usuario')
    Reserva.objects.filter(usuario__username__in=['turista1', 'turista2']).delete()
    Experiencia.objects.filter(creador__username__in=['guia1', 'guia2']).delete()
    Categoria.objects.filter(nombre__in=['Trekking', 'Canopy', 'Kayak', 'Arriendo de equipos']).delete()
    Usuario.objects.filter(username__in=['admin', 'guia1', 'guia2', 'turista1', 'turista2']).delete()


class Migration(migrations.Migration):
    dependencies = [
        ('experiencias', '0001_initial'),
    ]

    operations = [
        migrations.RunPython(cargar_datos, borrar_datos),
    ]