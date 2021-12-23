# Determine a docker image for python
FROM python:3.7-alpine
MAINTAINER KHHAN

# Let run faster
ENV PYTHONUNBUFFERED 1

# Install dependancies
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client jpeg-dev
RUN apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

# Setup working directory structure
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# Access blocks to irrelevant directory to prevent vicious appoach from hacker by -D
# Make all of the sub directories including the directory by -p
RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static
RUN adduser -D user
RUN chown -R user:user /vol/
RUN chmod -R 755 /vol/web
USER user