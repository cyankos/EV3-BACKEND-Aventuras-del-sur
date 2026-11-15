from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin
from .models import Usuario


class AdminRequiredMixin(LoginRequiredMixin, UserPassesTestMixin):
    def test_func(self):
        u = self.request.user
        return u.is_superuser or u.rol == Usuario.Rol.ADMIN


class AdminOGuiaRequiredMixin(LoginRequiredMixin, UserPassesTestMixin):
    def test_func(self):
        u = self.request.user
        return u.is_superuser or u.rol in (Usuario.Rol.ADMIN, Usuario.Rol.GUIA)
