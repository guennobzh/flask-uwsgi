#!/usr/bin/python
import os

# If virtual environement not created we create it
if not os.path.exists('/venv/bin'):

    # Install virtual environement
    os.system('python3 -m venv /venv')

    # If requirements.txt in present in app folder we use it tu create virtual environement
    if os.path.exists('/app/requirements.txt'):
        os.system('pip install -r /app/requirements.txt')

    # If there is no requirements.txt we create the virtual environement with default requirements
    else:
        os.system('pip install wheel uwsgi flask')

# Start uwsgi
os.system('/venv/bin/uwsgi --ini uwsgi.ini --pidfile=/tmp/uwsgi.pid')
