#!/bin/sh

. ../../docker.properties

sudo docker run -t -i --privileged --rm --name $STANDALONE_CONTAINER_NAME $DOCKER_USER/centos6-$STANDALONE_CONTAINER_NAME /bin/bash



