from django.db import models
from django.core.validators import int_list_validator


class User(models.Model):
    username = models.TextField(max_length=16, primary_key=True, unique=True)
    password = models.TextField(max_length=20)
    profiles = models.CharField(validators=[int_list_validator], max_length=100)
    updated = models.DateTimeField(auto_now=True)
    created = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['-created']


class Profile(models.Model):
    profileName = models.TextField(max_length=16)
    bodySizes = models.CharField(validators=[int_list_validator], max_length=100)
    updated = models.DateTimeField(auto_now=True)
    created = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['-updated']
