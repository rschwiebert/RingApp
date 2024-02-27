# To run the webserver in the container:
# (If `docker image list` does not have `ringapp` yet) Run `docker build . -t ringapp` in the RingApp directory.
# Copy RingApp/ringapp/local_settings.py.example to RingApp/ringapp/local_settings.py
# Run `docker run -d --name ringapp -v <absolute path to RingApp top level>:/checkout -v <absolute path to dart-data/db>:/data -p 8000:8000  ringapp`
# The server will be available at http://localhost:8000
# To interactively use the manage.py commands, or to play around with souffle, you can connect to the running container:
# `docker container list` and copy the hash of the rinagpp container
# `docker exec -it <image hash> /bin/bash`
# From there you can execute `python manage.py` commands and also `souffle` commands


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
