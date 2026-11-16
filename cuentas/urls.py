from django.urls import path
from .views import (
    UsuarioCreateView,
    UsuarioDeleteView,
    UsuarioListView,
    UsuarioUpdateView,
    RegistroTuristaView,
)

urlpatterns = [
    path("", UsuarioListView.as_view(), name="usuario_list"),
    path("nuevo/", UsuarioCreateView.as_view(), name="usuario_create"),
    path("registro/", RegistroTuristaView.as_view(), name="registro_turista"),
    path("<int:pk>/editar/", UsuarioUpdateView.as_view(), name="usuario_update"),
    path("<int:pk>/eliminar/", UsuarioDeleteView.as_view(), name="usuario_delete"),
]