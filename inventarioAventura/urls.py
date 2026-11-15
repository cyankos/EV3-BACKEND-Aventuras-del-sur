from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path("admin/", admin.site.urls),
    path("", include("core.urls")),
    path("cuentas/", include("django.contrib.auth.urls")),
    path("gestion/usuarios/", include("cuentas.urls")),
    path("", include("experiencias.urls")),
]
