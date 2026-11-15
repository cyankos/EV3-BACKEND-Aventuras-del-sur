from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.db import IntegrityError, transaction
from django.http import Http404, HttpResponseForbidden
from django.shortcuts import get_object_or_404, redirect, render
from django.urls import reverse_lazy
from django.views.decorators.http import require_POST
from django.views.generic import CreateView, DeleteView, ListView, UpdateView

from cuentas.mixins import AdminOGuiaRequiredMixin, AdminRequiredMixin
from cuentas.models import Usuario
from .forms import CategoriaForm, ExperienciaAdminForm, ExperienciaGuiaForm, ReservaAdminForm
from .models import Categoria, Experiencia, Reserva


def catalogo(request):
    experiencias = (
        Experiencia.objects.activas()
        .select_related("categoria", "creador")
        .order_by("fecha_hora")
    )
    return render(request, "experiencias/catalogo.html", {"experiencias": experiencias})


class CategoriaListView(AdminRequiredMixin, ListView):
    model = Categoria
    template_name = "experiencias/categoria_list.html"
    context_object_name = "categorias"


class CategoriaCreateView(AdminRequiredMixin, CreateView):
    model = Categoria
    form_class = CategoriaForm
    template_name = "experiencias/formulario.html"
    success_url = reverse_lazy("categoria_list")
    extra_context = {"titulo": "Nueva categoría"}


class CategoriaUpdateView(AdminRequiredMixin, UpdateView):
    model = Categoria
    form_class = CategoriaForm
    template_name = "experiencias/formulario.html"
    success_url = reverse_lazy("categoria_list")
    extra_context = {"titulo": "Editar categoría"}


class CategoriaDeleteView(AdminRequiredMixin, DeleteView):
    model = Categoria
    template_name = "experiencias/confirm_delete.html"
    success_url = reverse_lazy("categoria_list")
    extra_context = {"titulo": "Eliminar categoría"}

    def form_valid(self, form):
        messages.success(self.request, "Categoría eliminada correctamente.")
        return super().form_valid(form)


class ExperienciaListView(AdminOGuiaRequiredMixin, ListView):
    model = Experiencia
    template_name = "experiencias/experiencia_list.html"
    context_object_name = "experiencias"

    def get_queryset(self):
        qs = Experiencia.objects.select_related("categoria", "creador")
        u = self.request.user
        if u.is_superuser or u.rol == Usuario.Rol.ADMIN:
            return qs.order_by("fecha_hora")
        return qs.filter(creador=u).order_by("fecha_hora")


class ExperienciaCreateView(AdminOGuiaRequiredMixin, CreateView):
    model = Experiencia
    template_name = "experiencias/formulario.html"
    success_url = reverse_lazy("experiencia_list")
    extra_context = {"titulo": "Nueva experiencia"}

    def get_form_class(self):
        u = self.request.user
        if u.is_superuser or u.rol == Usuario.Rol.ADMIN:
            return ExperienciaAdminForm
        return ExperienciaGuiaForm

    def form_valid(self, form):
        if self.request.user.rol == Usuario.Rol.GUIA:
            form.instance.creador = self.request.user
        messages.success(self.request, "Experiencia guardada correctamente.")
        return super().form_valid(form)


class ExperienciaUpdateView(AdminOGuiaRequiredMixin, UpdateView):
    model = Experiencia
    template_name = "experiencias/formulario.html"
    success_url = reverse_lazy("experiencia_list")
    extra_context = {"titulo": "Editar experiencia"}

    def get_queryset(self):
        qs = Experiencia.objects.all()
        u = self.request.user
        if u.is_superuser or u.rol == Usuario.Rol.ADMIN:
            return qs
        return qs.filter(creador=u)

    def get_form_class(self):
        u = self.request.user
        if u.is_superuser or u.rol == Usuario.Rol.ADMIN:
            return ExperienciaAdminForm
        return ExperienciaGuiaForm

    def form_valid(self, form):
        if self.request.user.rol == Usuario.Rol.GUIA:
            form.instance.creador = self.request.user
        messages.success(self.request, "Experiencia actualizada.")
        return super().form_valid(form)


class ExperienciaDeleteView(AdminRequiredMixin, DeleteView):
    model = Experiencia
    template_name = "experiencias/confirm_delete.html"
    success_url = reverse_lazy("experiencia_list")
    extra_context = {"titulo": "Eliminar experiencia"}

    def form_valid(self, form):
        messages.success(self.request, "Experiencia eliminada correctamente.")
        return super().form_valid(form)


@login_required
@require_POST
def reservar_experiencia(request, pk):
    if request.user.rol != Usuario.Rol.TURISTA:
        return HttpResponseForbidden("Solo los turistas pueden reservar.")

    experiencia = get_object_or_404(
        Experiencia.objects.activas().select_related("categoria"),
        pk=pk,
    )

    if not experiencia.disponible:
        messages.error(request, "La experiencia ya no tiene cupos disponibles.")
        return redirect("catalogo")

    if Reserva.objects.filter(usuario=request.user, experiencia=experiencia).exists():
        messages.warning(request, "Ya tienes una reserva para esta experiencia.")
        return redirect("mis_reservas")

    try:
        with transaction.atomic():
            Reserva.objects.create(
                usuario=request.user,
                experiencia=experiencia,
                estado_pago=Reserva.EstadoPago.PENDIENTE,
            )
    except IntegrityError:
        messages.warning(request, "Ya existe una reserva para esta experiencia.")
    else:
        messages.success(request, "Reserva creada. Estado de pago: Pendiente.")
    return redirect("mis_reservas")


@login_required
def mis_reservas(request):
    if request.user.rol != Usuario.Rol.TURISTA:
        return redirect("panel")
    reservas = (
        Reserva.objects.filter(usuario=request.user)
        .select_related("experiencia", "experiencia__categoria")
        .order_by("-fecha_inscripcion")
    )
    return render(request, "experiencias/mis_reservas.html", {"reservas": reservas})


@login_required
def reservas_gestion(request):
    u = request.user
    if u.is_superuser or u.rol == Usuario.Rol.ADMIN:
        reservas = Reserva.objects.select_related("usuario", "experiencia", "experiencia__creador")
    elif u.rol == Usuario.Rol.GUIA:
        reservas = Reserva.objects.filter(
            experiencia__creador=u
        ).select_related("usuario", "experiencia")
    else:
        return redirect("mis_reservas")
    return render(request, "experiencias/reserva_list.html", {"reservas": reservas})


class ReservaUpdateView(AdminRequiredMixin, UpdateView):
    model = Reserva
    form_class = ReservaAdminForm
    template_name = "experiencias/formulario.html"
    success_url = reverse_lazy("reservas_gestion")
    extra_context = {"titulo": "Actualizar estado de pago"}


class ReservaDeleteView(AdminRequiredMixin, DeleteView):
    model = Reserva
    template_name = "experiencias/confirm_delete.html"
    success_url = reverse_lazy("reservas_gestion")
    extra_context = {"titulo": "Eliminar reserva"}

    def form_valid(self, form):
        messages.success(self.request, "Reserva eliminada correctamente.")
        return super().form_valid(form)
