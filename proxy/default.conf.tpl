server {
    # get port of env variable LISTEN_PORT (using 'run.sh')
    listen ${LISTEN_PORT};

    # setup a location to catch URLs for static 
    # maps requests for static (static/media files) onto containers /static/ dir (see 'settings.py')
    location /static {
        alias /vol/static;
    }

    # forwards non-static requests to uWSGI service
    # get env variables with 'run.sh' on startup
    location / {
        uwsgi_pass              ${APP_HOST}:${APP_PORT};
        include                 /etc/nginx/uwsgi_params;
        client_max_body_size    10M;
    }
}