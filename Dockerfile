# To build a local copy of the database:
# Change your working directory to be the directory containing the RingApp repository
# Run `docker build . -t ringapp` to build the docker image
# `touch db/ringapp.db` (or use some equivalent) to create this file
# Copy RingApp/ringapp/local_settings.py.example to RingApp/ringapp/local_settings.py
# Change `DISABLE_ENGINE = True` in local_settings
# Run `docker run -d --name ringapp -v <absolute path to repository directory>:/checkout -v <absolute path to dart-data/db>:/data -p 8000:8000  ringapp`
# The server should be available at http://localhost:8000
# Connect to the running container with `docker exec -it ringapp /bin/bash`
# Sourcing /venv/bin/activate to gain access to management commands
# Running `python manage.py db_to_data --settings=ringapp.local_settings import` will attempt to build the database up from
#   the format stored in dart-data.

# All management commands are available to you when connected to the server.  You can also use `souffle`.

# To use the webserver with a built database, you may wish to stop the container and
#    revert DISABLE_ENGINE to False, before starting the container again.


FROM ubuntu:22.04
EXPOSE 8000

VOLUME /checkout
VOLUME /data

ENV SECRET_KEY=verysecretkeyyoushouldchange
ENV EMAIL_HOST=smtp.gmail.com
ENV EMAIL_PORT=587
ENV REGISTRATION_DEFAULT_FROM_EMAIL=$EMAIL_HOST_USER
ENV EMAIL_HOST_PASSWORD=
ENV EMAIL_USE_TLS=true
ENV RECAPTCHA_PUBLIC_KEY=
ENV RECAPTCHA_PRIVATE_KEY=
ENV S3_BUCKET_NAME=
ENV EXPORT_ROOT_DIR=/data
ENV SQLITE_DB_DIR=/checkout/db

ADD requirements.txt requirements.txt

RUN apt update && \
    apt install -y \
    git \
    wget \
    python3 \
    python3-pip \
    python3-venv \
    python3-wheel \
    libpq-dev && \
    python3 -m venv /venv && \
    . /venv/bin/activate && \
    pip install -r /requirements.txt

WORKDIR /checkout

RUN wget https://souffle-lang.github.io/ppa/souffle-key.public -O /usr/share/keyrings/souffle-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/souffle-archive-keyring.gpg] https://souffle-lang.github.io/ppa/ubuntu/ stable main" | tee /etc/apt/sources.list.d/souffle.list && \
    apt update && \
    apt install -y souffle

ENTRYPOINT . /venv/bin/activate && \
python manage.py migrate --settings=ringapp.local_settings && \
python manage.py migrate --settings=ringapp.local_settings --database ringapp_data && \
python manage.py runserver --settings=ringapp.local_settings 0:8000
