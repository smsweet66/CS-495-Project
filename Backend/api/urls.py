from django.urls import path
from knox import views
from .views import *

urlpatterns = [
    path('', getRoutes),
    path('profiles', getProfiles),
    path('profiles/create', createProfile),
    path('profiles/<int:pid>/update', updateProfile),
    path('profiles/<int:pid>/delete', deleteProfile),
    path('profiles/<int:pid>', getProfile),
    path('register', RegisterAPI.as_view(), name='Register'),
    path('login', LoginAPI.as_view(), name='Login'),
    path('logout', views.LogoutView.as_view(), name='Logout'),
]
