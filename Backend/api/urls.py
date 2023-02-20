from django.urls import path
from . import views

urlpatterns = [
    path('', views.getRoutes),
    path('profiles', views.getProfiles),
    path('profiles/create', views.createProfile),
    path('profiles/<int:pid>/update', views.updateProfile),
    path('profiles/<int:pid>/delete', views.deleteProfile),
    path('profiles/<int:pid>', views.getProfile)
]
