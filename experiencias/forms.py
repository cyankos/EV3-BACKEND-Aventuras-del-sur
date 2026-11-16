from django import forms
from cuentas.models import Usuario
from .models import Categoria, Experiencia, Reserva


class CategoriaForm(forms.ModelForm):
    class Meta:
        model = Categoria
        fields = "__all__"
        widgets = {
            "nombre": forms.TextInput(attrs={"class": "form-control"}),
            "descripcion": forms.Textarea(
                attrs={"class": "form-control", "rows": 3}
            ),
            "activo": forms.CheckboxInput(
                attrs={"class": "form-check-input"}
            ),
        }


class ExperienciaGuiaForm(forms.ModelForm):
    class Meta:
        model = Experiencia
        fields = (
            "titulo",
            "descripcion",
            "precio",
            "cupo_maximo",
            "fecha_hora",
            "categoria",
        )
        widgets = {
            "titulo": forms.TextInput(attrs={"class": "form-control"}),
            "descripcion": forms.Textarea(
                attrs={"class": "form-control", "rows": 4}
            ),
            "precio": forms.NumberInput(
                attrs={
                    "class": "form-control",
                    "min": "1",
                    "step": "0.01",
                }
            ),
            "cupo_maximo": forms.NumberInput(
                attrs={"class": "form-control", "min": "1"}
            ),
            "fecha_hora": forms.DateTimeInput(
                attrs={
                    "class": "form-control",
                    "type": "datetime-local",
                },
                format="%Y-%m-%dT%H:%M",
            ),
            "categoria": forms.Select(
                attrs={"class": "form-control"}
            ),
        }


class ExperienciaAdminForm(ExperienciaGuiaForm):
    creador = forms.ModelChoiceField(
        queryset=Usuario.objects.none(),
        widget=forms.Select(attrs={"class": "form-control"}),
    )

    class Meta(ExperienciaGuiaForm.Meta):
        fields = ExperienciaGuiaForm.Meta.fields + ("creador",)

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields["creador"].queryset = Usuario.objects.filter(
            rol__in=[Usuario.Rol.ADMIN, Usuario.Rol.GUIA],
            is_active=True,
        ).order_by("username")


class ReservaAdminForm(forms.ModelForm):
    class Meta:
        model = Reserva
        fields = ("estado_pago",)
        widgets = {
            "estado_pago": forms.Select(
                attrs={"class": "form-control"}
            ),
        }