FROM ubuntu:16.04

MAINTAINER Lyudmyla Kaluzhynova "kaluzhynova@gmail.com"
ENV PYTHONUNBUFFERED 1
ENV POSTGRES_USER postgres
ENV POSTGRES_PASSWORD 12345
ENV POSTGRES_DB postgres
ENV POSTGRES_HOST db
RUN apt-get update && apt-get install curl -y \
    git \
    python3 \
    python3-pip \
    nginx \
    postgresql \
    postgresql-contrib \
    pwgen && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && apt-get install nodejs -y 
RUN npm install

RUN npm install react react-dom react-addons-css-transition-group react-router

RUN mkdir /code
 WORKDIR /code
 ADD requirements.txt /code/
 RUN pip3 install -r requirements.txt
 ADD . /code/
 EXPOSE 80
 CMD [ "webpack --watch --watch-polling", "python3","manage.py", "runserver", "0.0.0.0:8000"]


