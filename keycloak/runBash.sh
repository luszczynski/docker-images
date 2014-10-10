#!/bin/sh

. ../docker.properties

sudo docker run -t -i --privileged --rm --name $KEYCLOAK_CONTAINER_NAME $DOCKER_USER/centos6-$KEYCLOAK_CONTAINER_NAME /bin/bash



