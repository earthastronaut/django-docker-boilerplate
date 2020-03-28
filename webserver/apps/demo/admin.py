from django.contrib import admin

from demo import models


class GraditudeAdmin(admin.ModelAdmin):
    pass


admin.site.register(models.Graditude, GraditudeAdmin)
