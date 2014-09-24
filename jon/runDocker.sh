#!/bin/sh

. ../docker.properties

sudo docker run --privileged -p 127.0.0.1:7080:7080 -d --name $JON_SERVER_CONTAINER_NAME $DOCKER_USER/centos6-$JON_SERVER_CONTAINER_NAME
#sudo docker logs -f $JON_SERVER_CONTAINER_NAME
