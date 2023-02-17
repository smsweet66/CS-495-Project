from django.db import models
from django.core.validators import int_list_validator


class Profile(models.Model):
    profileName = models.TextField(max_length=16)
    bodySizes = models.CharField(validators=[int_list_validator], max_length=100)
    updated = models.DateTimeField(auto_now=True)
    created = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['-updated']
