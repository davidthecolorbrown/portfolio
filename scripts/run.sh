#!/bin/sh
# run.sh
# script for running application when deployed to remote server (runs using uwgsi server instead of django dev server)

# 
set -e
#
ls -la /vol/
ls -la /vol/web
#
whoami
# have application wait until postgres database starts
python manage.py wait_for_db
# have django collect all static files across all apps and put in one place
# these are stored in the static root path in 'settings.py'
python manage.py collectstatic --noinput
# update db
python manage.py migrate
# run uwsgi service
# run on socket (connection between nginx and uwsgi) 9000
# number of workers that can take requests 
# master foreground daemon outputs logs to docker logs
# enable multithreading
# run 'app.wsgi.py' in app main dir
uwsgi --socket :9000 --workers 4 --master --enable-threads --module app.wsgi