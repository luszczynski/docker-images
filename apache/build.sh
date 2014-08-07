#!/bin/sh

. ../docker.properties

sudo docker build --rm=true --force-rm=true -t centos6/$APACHE_CONTAINER_NAME .
