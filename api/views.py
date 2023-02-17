from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import ProfileSerializer
from .models import Profile


@api_view(['GET'])
def getRoutes(request):
    routes = [
        {
            'Endpoint': '/profiles/',
            'method': 'GET',
            'body': None,
            'description': 'lists all local profiles'
        },
        {
            'Endpoint': '/profiles/create/',
            'method': 'Post',
            'body': None,
            'description': 'creates a new profile'
        },
        {
            'Endpoint': '/profiles/name/',
            'method': 'GET',
            'body': None,
            'description': 'lists a specific profile'
        },
        {
            'Endpoint': '/profiles/name/update/',
            'method': 'PUT',
            'body': None,
            'description': 'updates a specific profile'
        },
        {
            'Endpoint': '/profiles/name/delete/',
            'method': 'DELETE',
            'body': None,
            'description': 'Deletes a specific profile'
        }
    ]

    return Response(routes)


@api_view(['GET'])
def getProfiles(request):
    profiles = Profile.objects.all()
    serializer = ProfileSerializer(profiles, many=True)

    return Response(serializer.data)
