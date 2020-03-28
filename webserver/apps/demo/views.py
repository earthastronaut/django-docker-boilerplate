from django.shortcuts import render

# Create your views here.
from django.contrib.auth.decorators import login_required
from django.conf import settings

from demo import models


@login_required
def index(request):
    gratitudes = models.Graditude.objects.filter(user=request.user)
    context = {
        'database_backend': settings.DEMO_CHOOSE_DATABASE_DEFAULT,
        'gratitudes': gratitudes,
    }
    return render(request, 'demo/index.html', context)
