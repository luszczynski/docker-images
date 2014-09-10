#!/bin/sh

. ../docker.properties

sudo docker run --privileged --rm -p 127.0.0.1:8181:8181 --name $FUSE_CONTAINER_NAME $DOCKER_USER/centos6-$FUSE_CONTAINER_NAME
