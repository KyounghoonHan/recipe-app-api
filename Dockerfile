# Determine a docker image for python
FROM python:3.7-alpine
MAINTAINER KHHAN

# Let run faster
ENV PYTHONUNBUFFERED 1

# Install dependancies
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

# Setup working directory structure
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# Add users with -D will block access to irrelevant directory to prevent vicious appoach from hacker
RUN adduser -D user
USER user