from django.conf import settings
from django.db import models
from django.db.models import Count, Q
from django.utils import timezone


class Categoria(models.Model):
    nombre = models.CharField(max_length=80, unique=True)
    descripcion = models.TextField()
    activo = models.BooleanField(default=True)

    class Meta:
        ordering = ["nombre"]

    def __str__(self):
        return self.nombre


class ExperienciaQuerySet(models.QuerySet):
    def activas(self):
        return self.filter(categoria__activo=True, fecha_hora__gte=timezone.now())


class Experiencia(models.Model):
    titulo = models.CharField(max_length=120)
    descripcion = models.TextField()
    precio = models.DecimalField(max_digits=10, decimal_places=2)
    cupo_maximo = models.PositiveIntegerField()
    fecha_hora = models.DateTimeField()
    categoria = models.ForeignKey(Categoria, on_delete=models.CASCADE, related_name="experiencias")
    creador = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name="experiencias_creadas",
    )

    objects = ExperienciaQuerySet.as_manager()

    class Meta:
        ordering = ["fecha_hora", "titulo"]

    def __str__(self):
        return self.titulo

    @property
    def cupos_ocupados(self):
        return self.reservas.count()

    @property
    def cupos_disponibles(self):
        return max(self.cupo_maximo - self.cupos_ocupados, 0)

    @property
    def disponible(self):
        return self.categoria.activo and self.fecha_hora >= timezone.now() and self.cupos_disponibles > 0


class Reserva(models.Model):
    class EstadoPago(models.TextChoices):
        PENDIENTE = "pendiente", "Pendiente"
        CONFIRMADO = "confirmado", "Confirmado"

    usuario = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name="reservas",
    )
    experiencia = models.ForeignKey(
        Experiencia,
        on_delete=models.CASCADE,
        related_name="reservas",
    )
    fecha_inscripcion = models.DateTimeField(auto_now_add=True)
    estado_pago = models.CharField(
        max_length=12,
        choices=EstadoPago.choices,
        default=EstadoPago.PENDIENTE,
    )

    class Meta:
        ordering = ["-fecha_inscripcion"]
        constraints = [
            models.UniqueConstraint(
                fields=["usuario", "experiencia"],
                name="reserva_usuario_experiencia_unica",
            )
        ]

    def __str__(self):
        return f"{self.usuario.username} - {self.experiencia.titulo}"
