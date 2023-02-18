from django import forms
from .models import *


class UserForm(forms.ModelForm):
    class Meta:
        model = User

        fields = [
            'username',
            'password',
            'profiles',
            'updated',
            'created'
        ]

        widgets = {
            'password': forms.PasswordInput
        }
