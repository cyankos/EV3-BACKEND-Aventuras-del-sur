from django.contrib.auth.models import AbstractUser
from django.db import models


class Usuario(AbstractUser):
    class Rol(models.TextChoices):
        ADMIN = "admin", "Administrador"
        GUIA = "guia", "Guía / Operador"
        TURISTA = "turista", "Turista / Cliente"

    rol = models.CharField(max_length=10, choices=Rol.choices, default=Rol.TURISTA)

    def __str__(self):
        nombre = self.get_full_name().strip()
        return f"{nombre or self.username} - {self.get_rol_display()}"
