#!/bin/sh

. ../../docker.properties

sudo docker build --rm=true --force-rm=true -t $DOCKER_USER/centos6-$HOST_CONTAINER_NAME .
