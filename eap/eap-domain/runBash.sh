#!/bin/sh

. ../../docker.properties

sudo docker run -t -i --privileged --rm --name $DOMAIN_CONTROLLER_CONTAINER_NAME $DOCKER_USER/centos6-$DOMAIN_CONTROLLER_CONTAINER_NAME /bin/bash



