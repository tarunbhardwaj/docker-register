FROM ubuntu:14.04
MAINTAINER Tarun Bhardwaj <mailme@tarunbhardwaj.com>

RUN apt-get update
RUN apt-get install -y wget python python-pip python-dev libssl-dev libffi-dev bash

RUN mkdir /app
WORKDIR /app

RUN wget https://github.com/jwilder/docker-gen/releases/download/0.4.1/docker-gen-linux-amd64-0.4.1.tar.gz
RUN tar xvzf docker-gen-linux-amd64-0.4.1.tar.gz -C /usr/local/bin

RUN pip install redis

ADD . /app

ENV DOCKER_HOST unix:///var/run/docker.sock

CMD docker-gen -interval 10 -watch -notify "python /tmp/notify.py" /etc/exec.tmpl /tmp/notify.py
