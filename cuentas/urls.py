from django.urls import path
from .views import UsuarioCreateView, UsuarioDeleteView, UsuarioListView, UsuarioUpdateView

urlpatterns = [
    path("", UsuarioListView.as_view(), name="usuario_list"),
    path("nuevo/", UsuarioCreateView.as_view(), name="usuario_create"),
    path("<int:pk>/editar/", UsuarioUpdateView.as_view(), name="usuario_update"),
    path("<int:pk>/eliminar/", UsuarioDeleteView.as_view(), name="usuario_delete"),
]
