from django.contrib.auth import login
from django.core.exceptions import MultipleObjectsReturned
from knox.models import AuthToken
from knox.views import LoginView
from knox.auth import TokenAuthentication
from rest_framework import generics, permissions
from rest_framework.authtoken.serializers import AuthTokenSerializer
from rest_framework.decorators import api_view, authentication_classes, permission_classes
from rest_framework.response import Response
from .serializers import ProfileSerializer, RegisterSerializer, UserSerializer
from .models import Profile


@api_view(['GET'])
def getRoutes(request):
    routes = [
        {
            'Endpoint': '/profiles',
            'method': 'GET',
            'body': None,
            'description': 'lists all local profiles'
        },
        {
            'Endpoint': '/profiles/create',
            'method': 'Post',
            'body': None,
            'description': 'creates a new profile'
        },
        {
            'Endpoint': '/profiles/name',
            'method': 'GET',
            'body': None,
            'description': 'lists a specific profile'
        },
        {
            'Endpoint': '/profiles/name/update',
            'method': 'PUT',
            'body': None,
            'description': 'updates a specific profile'
        },
        {
            'Endpoint': '/profiles/name/delete',
            'method': 'DELETE',
            'body': None,
            'description': 'deletes a specific profile'
        },
        {
            'Endpoint': '/register',
            'method': 'POST',
            'body': None,
            'description': 'creates a user account'
        },
        {
            'Endpoint': '/login',
            'method': 'POST',
            'body': None,
            'description': 'logs into an existing account'
        },
        {
            'Endpoint': '/logout',
            'method': 'POST',
            'body': None,
            'description': 'logs out of the user account'
        }
    ]

    return Response(routes)


@api_view(['GET'])
@authentication_classes([TokenAuthentication])
@permission_classes([permissions.IsAuthenticated])
def getProfiles(request):
    profiles = Profile.objects.filter(user=request.user)
    serializer = ProfileSerializer(profiles, many=True)

    return Response(serializer.data)


@api_view(['GET'])
@authentication_classes([TokenAuthentication])
@permission_classes([permissions.IsAuthenticated])
def getProfile(request, pid):
    try:
        profile = Profile.objects.get(user=request.user, id=pid)
        serializer = ProfileSerializer(profile, many=False)

        return Response(serializer.data)
    except Profile.DoesNotExist:
        return Response("The profile either does not exist, or does not belong to this user")
    except MultipleObjectsReturned:
        return Response("Multiple objects found with this id")


@api_view(['POST'])
@authentication_classes([TokenAuthentication])
@permission_classes([permissions.IsAuthenticated])
def createProfile(request):
    data = request.data
    profile = Profile.objects.create(
        profileName=data['profileName'],
        user=request.user,
        bodySizes=data['bodySizes']
    )

    serializer = ProfileSerializer(profile, many=False)
    return Response(serializer.data)


@api_view(['PUT'])
@authentication_classes([TokenAuthentication])
@permission_classes([permissions.IsAuthenticated])
def updateProfile(request, pid):
    profile = Profile.objects.get(user=request.user, id=pid)

    serializer = ProfileSerializer(profile, data=request.data)
    if serializer.is_valid():
        serializer.save()
    else:
        print(serializer.errors)

    return Response(serializer.data)


@api_view(['DELETE'])
@authentication_classes([TokenAuthentication])
@permission_classes([permissions.IsAuthenticated])
def deleteProfile(request, pid):
    profile = Profile.objects.get(id=pid)
    profile.delete()

    return Response('Profile was deleted!')


class RegisterAPI(generics.GenericAPIView):
    serializer_class = RegisterSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.save()

        return Response({
            "user": UserSerializer(user, context=self.get_serializer_context()).data,
            "token": AuthToken.objects.create(user)[1]
        })


class LoginAPI(LoginView):
    permission_classes = (permissions.AllowAny,)

    def post(self, request, format=None):
        serializer = AuthTokenSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        login(request, user)
        return super(LoginAPI, self).post(request, format=None)
