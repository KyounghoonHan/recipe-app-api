# Determine a docker image for python
FROM python:3.7-alpine
MAINTAINER KHHAN

# Let run faster
ENV PYTHONUNBUFFERED 1

# Install dependancies
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# Setup working directory structure
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# Add users with -D will block access to irrelevant directory to prevent vicious appoach from hacker
RUN adduser -D user
USER user