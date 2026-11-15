from django.contrib import admin
from .models import Categoria, Experiencia, Reserva


@admin.register(Categoria)
class CategoriaAdmin(admin.ModelAdmin):
    list_display = ("nombre", "activo")
    search_fields = ("nombre",)
    list_filter = ("activo",)


@admin.register(Experiencia)
class ExperienciaAdmin(admin.ModelAdmin):
    list_display = ("titulo", "categoria", "precio", "cupo_maximo", "fecha_hora", "creador")
    search_fields = ("titulo", "descripcion", "creador__username")
    list_filter = ("categoria", "fecha_hora")
    autocomplete_fields = ("creador",)


@admin.register(Reserva)
class ReservaAdmin(admin.ModelAdmin):
    list_display = ("usuario", "experiencia", "fecha_inscripcion", "estado_pago")
    search_fields = ("usuario__username", "experiencia__titulo")
    list_filter = ("estado_pago", "fecha_inscripcion")
