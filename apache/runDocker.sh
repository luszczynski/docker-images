#!/bin/sh

. ../docker.properties

sudo docker run --privileged -p 127.0.0.1:80:80 -d --name $APACHE_CONTAINER_NAME $DOCKER_USER/centos6-$APACHE_CONTAINER_NAME
#sudo docker logs -f $APACHE_CONTAINER_NAME
