# CS-495-Project
## Testing:
### Backend
The backend of this project was mostly tested using postman to make http requests to the server.  
Using postman, we would access each endpoint to ensure it provided the proper responses to requests.  
If we did not specify a token then any attempt to access server information was rejected.
### Frontend
The frontend of this project was tested by running it.  Android studio allows the user to emulate  
an android phone to use the app, which can be hot reloaded.  This means that we can make adjustments  
to the code and have them appear on the app without having to recompile and restart the app.

## How to use the app
Currently, the server is locally hosted, so the app cannot be run (technically it can, but you won't  
be able to get past the login page) without starting the server beforehand.  This can be done with the command  
"/Backend/manage.py runserver".  Starting the app requires that flutter is installed onto the computer.  
The main file for the app is located in the Frontend/lib folder.
