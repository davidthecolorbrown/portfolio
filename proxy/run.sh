#!/bin/sh
# run.sh
# gets env variables when docker container starts and uses these to config and start nginx proxy

# 
set -e
# get the env variable for port LISTEN_PORT and substitute matching variables with env variables (envsubst) to config nginx conf file
envsubst < /etc/nginx/default.conf.tpl > /etc/nginx/conf.d/default.conf
# starts nginx and run in foreground in docker container
nginx -g 'daemon off;'