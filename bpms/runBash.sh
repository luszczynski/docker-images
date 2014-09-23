#!/bin/sh

. ../docker.properties

sudo docker run -t -i --privileged --rm --name $BPMS_CONTAINER_NAME $DOCKER_USER/centos6-$BPMS_CONTAINER_NAME /bin/bash



