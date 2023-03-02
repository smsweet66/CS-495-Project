from django.db import models
from django.contrib.auth.models import User
from django.core.validators import int_list_validator


class Profile(models.Model):
    profileName = models.TextField(max_length=16)
    user = models.ForeignKey(User, on_delete=models.CASCADE, default=None)
    bodySizes = models.CharField(validators=[int_list_validator], max_length=100)
    updated = models.DateTimeField(auto_now=True)
    created = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['-updated']
