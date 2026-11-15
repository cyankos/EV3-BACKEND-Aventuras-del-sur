from django.contrib import messages
from django.urls import reverse_lazy
from django.views.generic import CreateView, DeleteView, ListView, UpdateView

from .forms import UsuarioCrearForm, UsuarioEditarForm
from .mixins import AdminRequiredMixin
from .models import Usuario


class UsuarioListView(AdminRequiredMixin, ListView):
    model = Usuario
    template_name = "cuentas/usuario_list.html"
    context_object_name = "usuarios"
    queryset = Usuario.objects.order_by("rol", "username")


class UsuarioCreateView(AdminRequiredMixin, CreateView):
    model = Usuario
    form_class = UsuarioCrearForm
    template_name = "cuentas/usuario_form.html"
    success_url = reverse_lazy("usuario_list")

    def form_valid(self, form):
        messages.success(self.request, "Usuario creado correctamente.")
        return super().form_valid(form)


class UsuarioUpdateView(AdminRequiredMixin, UpdateView):
    model = Usuario
    form_class = UsuarioEditarForm
    template_name = "cuentas/usuario_form.html"
    success_url = reverse_lazy("usuario_list")

    def form_valid(self, form):
        messages.success(self.request, "Usuario actualizado correctamente.")
        return super().form_valid(form)


class UsuarioDeleteView(AdminRequiredMixin, DeleteView):
    model = Usuario
    template_name = "cuentas/usuario_confirm_delete.html"
    success_url = reverse_lazy("usuario_list")

    def form_valid(self, form):
        if self.object.pk == self.request.user.pk:
            messages.error(self.request, "No puedes eliminar tu propia cuenta.")
            return self.get(self.request)
        messages.success(self.request, "Usuario eliminado.")
        return super().form_valid(form)
