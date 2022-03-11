FROM python:3.9-alpine3.13
# 
#LABEL maintainer="changeme@gmail.com"

ENV PYTHONUNBUFFERED 1

# copy project code and dependencies to docker image
COPY ./requirements.txt /requirements.txt
COPY ./app /app
COPY ./scripts /scripts

# set the root directory
WORKDIR /app

# expose container port 8000
EXPOSE 8000

# 
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    apk add --update --no-cache postgresql-client && \
    apk add --update --no-cache --virtual .tmp-deps \
        build-base postgresql-dev musl-dev linux-headers && \
    /py/bin/pip install -r /requirements.txt && \
    apk del .tmp-deps && \
    adduser --disabled-password --no-create-home app && \
    mkdir -p /vol/web/static && \
    mkdir -p /vol/web/media && \
    chown -R app:app /vol && \
    chmod -R 755 /vol && \
    chmod -R +x /scripts

# have 'scripts/' and 'py/bin/' both in PATH so you can avoid calling these by full path
ENV PATH="/scripts:/py/bin:$PATH"

# create and change to non-root user
USER app

# run script on container startup
CMD ["run.sh"]