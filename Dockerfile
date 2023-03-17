# Base image
FROM ubuntu:20.04

# Installing prerequisite packages
RUN DEBIAN_FRONTEND="noninteractive" apt-get update && apt-get install -y tzdata keyboard-configuration
RUN apt-get -y install curl unzip groff less nodejs npm vim

# AWS CLI installation commands
RUN	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN	unzip awscliv2.zip && ./aws/install

#Definição do ambiente
ENV NODE_ENV=production

RUN mkdir -p /root/.aws

COPY ["credentials", "/root/.aws"]

#Diretório de trabalho
WORKDIR /app

RUN npm install aws-sdk

#COPY ["package.json", "package-lock.json*", "./"]

#RUN npm install --production

COPY . .

#CMD [ "node", "server.js" ]
