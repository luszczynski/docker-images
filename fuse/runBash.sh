#!/bin/sh

. ../docker.properties

sudo docker run -t -i --privileged -p 127.0.0.1:8181:8181 --rm --name $FUSE_CONTAINER_NAME $DOCKER_USER/centos6-$FUSE_CONTAINER_NAME /bin/bash



