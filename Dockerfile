FROM ubuntu:latest AS base
LABEL maintainer="Paavan <paavan@protonmail.com>"
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update \
	&& apt install -y --no-install-recommends \
    wget \
    curl \
    cmake \
    make \
    build-essential \
    libyaml-0-2 \
    ca-certificates \
    ncat \
    git

# WORKDIR /app

RUN apt-get -y install nginx \
    && apt-get -y install python3-dev \
    && apt-get -y install build-essential
RUN apt-get install -y gcc
RUN apt-get update && apt-get install -y uwsgi
RUN apt-get install -y default-libmysqlclient-dev
RUN apt-get update && apt-get install libssl-dev
RUN apt-get install -y mariadb-client

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY . /ecs-fargate-pv1.4-falco
RUN /ecs-fargate-pv1.4-falco/bin/build
CMD ["/ecs-fargate-pv1.4-falco/bin/falco"]
