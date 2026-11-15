from django.urls import path
from . import views

urlpatterns = [
    path("experiencias/", views.catalogo, name="catalogo"),
    path("experiencias/<int:pk>/reservar/", views.reservar_experiencia, name="reservar_experiencia"),
    path("mis-reservas/", views.mis_reservas, name="mis_reservas"),

    path("gestion/categorias/", views.CategoriaListView.as_view(), name="categoria_list"),
    path("gestion/categorias/nueva/", views.CategoriaCreateView.as_view(), name="categoria_create"),
    path("gestion/categorias/<int:pk>/editar/", views.CategoriaUpdateView.as_view(), name="categoria_update"),
    path("gestion/categorias/<int:pk>/eliminar/", views.CategoriaDeleteView.as_view(), name="categoria_delete"),

    path("gestion/experiencias/", views.ExperienciaListView.as_view(), name="experiencia_list"),
    path("gestion/experiencias/nueva/", views.ExperienciaCreateView.as_view(), name="experiencia_create"),
    path("gestion/experiencias/<int:pk>/editar/", views.ExperienciaUpdateView.as_view(), name="experiencia_update"),
    path("gestion/experiencias/<int:pk>/eliminar/", views.ExperienciaDeleteView.as_view(), name="experiencia_delete"),

    path("gestion/reservas/", views.reservas_gestion, name="reservas_gestion"),
    path("gestion/reservas/<int:pk>/editar/", views.ReservaUpdateView.as_view(), name="reserva_update"),
    path("gestion/reservas/<int:pk>/eliminar/", views.ReservaDeleteView.as_view(), name="reserva_delete"),
]
