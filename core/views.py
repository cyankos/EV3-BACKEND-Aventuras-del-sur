from django.contrib.auth.decorators import login_required
from django.shortcuts import redirect, render

from cuentas.models import Usuario
from experiencias.models import Categoria, Experiencia, Reserva


def index(request):
    experiencias = (
        Experiencia.objects.activas()
        .select_related("categoria", "creador")
        .order_by("fecha_hora")[:6]
    )
    return render(request, "core/index.html", {"experiencias": experiencias})


@login_required
def panel(request):
    if request.user.is_superuser or request.user.rol == Usuario.Rol.ADMIN:
        return redirect("dashboard_admin")
    if request.user.rol == Usuario.Rol.GUIA:
        return redirect("dashboard_guia")
    return redirect("dashboard_turista")


@login_required
def dashboard_admin(request):
    if not (request.user.is_superuser or request.user.rol == Usuario.Rol.ADMIN):
        return redirect("panel")
    data = {
        "usuarios": Usuario.objects.count(),
        "categorias": Categoria.objects.count(),
        "experiencias": Experiencia.objects.count(),
        "reservas": Reserva.objects.count(),
    }
    return render(request, "core/dashboard_admin.html", data)


@login_required
def dashboard_guia(request):
    if request.user.rol != Usuario.Rol.GUIA:
        return redirect("panel")
    propias = Experiencia.objects.filter(creador=request.user)
    data = {
        "experiencias": propias.count(),
        "reservas": Reserva.objects.filter(experiencia__creador=request.user).count(),
        "proximas": propias.order_by("fecha_hora")[:5],
    }
    return render(request, "core/dashboard_guia.html", data)


@login_required
def dashboard_turista(request):
    if request.user.rol != Usuario.Rol.TURISTA:
        return redirect("panel")
    propias = Reserva.objects.filter(usuario=request.user)
    data = {
        "reservas": propias.count(),
        "confirmadas": propias.filter(estado_pago=Reserva.EstadoPago.CONFIRMADO).count(),
        "proximas": propias.select_related("experiencia").order_by("experiencia__fecha_hora")[:5],
    }
    return render(request, "core/dashboard_turista.html", data)
