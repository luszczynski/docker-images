#!/bin/sh

. ../../docker.properties

sudo docker run -t -i --privileged --rm --name $HOST_CONTAINER_NAME $DOCKER_USER/centos6-$HOST_CONTAINER_NAME /bin/bash



