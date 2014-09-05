#!/bin/sh

. ../../docker.properties

sudo docker build --rm=true --force-rm=true -t $DOCKER_USER/centos6-$DOMAIN_CONTROLLER_CONTAINER_NAME .
