# use nginx image from docker-hub (unprivileged user can run nginx)
FROM nginxinc/nginx-unprivileged:1-alpine

# 
#LABEL maintainer="changeme@gmail.com"

# copy files in dir to docker container 
COPY ./default.conf.tpl /etc/nginx/default.conf.tpl
COPY ./uwsgi_params /etc/nginx/uwsgi_params
COPY ./run.sh /run.sh

# set default env variables for nginx (can override when running container)
# have nginx to listen to port 8000 on port 
ENV LISTEN_PORT=8000
# name of service running django application
ENV APP_HOST=app
# listen to container port 9000 (configured with uwsgi service)
ENV APP_PORT=9000

# switch to root user
USER root

# make directories and change permissions
RUN mkdir -p /vol/static && \
    chmod 755 /vol/static && \
    touch /etc/nginx/conf.d/default.conf && \
    chown nginx:nginx /etc/nginx/conf.d/default.conf && \
    chmod +x /run.sh

# 
VOLUME /vol/static

# create nginx user
USER nginx

# run bash script on startup/build
CMD ["/run.sh"]