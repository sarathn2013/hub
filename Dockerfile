FROM node:latest

MAINTAINER sarath

RUN apt-get update && apt-get -qy install git-core redis-server && apt-get install sudo
RUN sudo apt-get -qq update && sudo apt-get install -y curl
RUN npm install -g yo generator-hubot coffee-script
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN sudo mv ./kubectl /usr/local/bin/kubectl
RUN kubectl config set-cluster default --server=https://api.wesomekubernetes.de --insecure-skip-tls-verify=true

#RUN kubectl config set-context default --cluster=default --user=deploy_bot

RUN adduser --disabled-password --gecos "" yeoman; \
  echo "yeoman ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
ENV HOME /home/yeoman
USER yeoman
WORKDIR /home/yeoman

RUN npm install

CMD cd hubot; bin/hubot --adapter slack
