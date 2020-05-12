# uSWGI server with flask

Run a flask app with uWSGI in a tcp socket to be user behind a reverse proxy like nginx.

## Usage examples
### Quickstart
    docker run --name flask-uwsgi -p 3000:3000 guennobzh/flask-uwsgi
Setup web server to connect to the swgi server. Example for nginx:
```
server {
  listen              80;
  server_name         example.com;
  location / {
    include uwsgi_params;
    uwsgi_pass 127.0.0.1:3000;
  }
}
```
### Mount local app and virtual environment
    docker run --name flask-uwsgi -v /path/to/localvenvfolder:/venv -v /path/to/localappfolder:/app -p 3000:3000 guennobzh/flask-uwsgi
If the localappfolder contain requirements.txt and the venv folder is empty the script create a new virtual environment with the requirements in requirements.txt (must contain at less wheel, uwsgi and flask).

uWSIG user /app/uwsgi.ini as config file
### Manage pip package
    docker exec flask-uwsgi pip install --upgrade pip
