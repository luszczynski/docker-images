#!/bin/sh

. ../../docker.properties

sudo docker build --rm=true --force-rm=true -t centos6/$DOMAIN_CONTROLLER_CONTAINER_NAME .
