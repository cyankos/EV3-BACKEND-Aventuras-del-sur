from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):
    dependencies = [
        ("experiencias", "0002_datos_demo"),
    ]

    operations = [
        migrations.AlterField(
            model_name="experiencia",
            name="categoria",
            field=models.ForeignKey(
                on_delete=django.db.models.deletion.CASCADE,
                related_name="experiencias",
                to="experiencias.categoria",
            ),
        ),
        migrations.AlterField(
            model_name="experiencia",
            name="creador",
            field=models.ForeignKey(
                on_delete=django.db.models.deletion.CASCADE,
                related_name="experiencias_creadas",
                to=settings.AUTH_USER_MODEL,
            ),
        ),
        migrations.AlterField(
            model_name="reserva",
            name="experiencia",
            field=models.ForeignKey(
                on_delete=django.db.models.deletion.CASCADE,
                related_name="reservas",
                to="experiencias.experiencia",
            ),
        ),
    ]
