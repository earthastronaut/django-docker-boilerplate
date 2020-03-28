from django.db import models
from django.contrib.auth.models import User


class Graditude(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    description = models.CharField(max_length=255)

    def __str__(self):
        return f'{self.user.username} is grateful for {self.description}'
