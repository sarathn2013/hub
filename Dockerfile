FROM node:latest

MAINTAINER Lin Wen Chun

RUN apt-get -q update
RUN apt-get -qy install git-core redis-server
RUN apt-get install sudo

RUN npm install -g yo generator-hubot coffee-script

RUN adduser --disabled-password --gecos "" yeoman; \
  echo "yeoman ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
ENV HOME /home/yeoman
USER yeoman
WORKDIR /home/yeoman

RUN git clone https://github.com/sarathn2013/slack-hubot.git hubot
RUN cd hubot; npm install

CMD cd hubot; bin/hubot --adapter slack
