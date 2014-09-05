#!/bin/sh

. ../docker.properties

sudo docker build -t $DOCKER_USER/centos6-$JON_SERVER_CONTAINER_NAME .
