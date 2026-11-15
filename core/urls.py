from django.urls import path
from . import views

urlpatterns = [
    path("", views.index, name="inicio"),
    path("panel/", views.panel, name="panel"),
    path("panel/admin/", views.dashboard_admin, name="dashboard_admin"),
    path("panel/guia/", views.dashboard_guia, name="dashboard_guia"),
    path("panel/turista/", views.dashboard_turista, name="dashboard_turista"),
]
