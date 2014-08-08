#!/bin/sh

. ../docker.properties

sudo docker run --privileged -p 127.0.0.1:7080:7080 --rm --name $JON_SERVER_CONTAINER_NAME centos6/$JON_SERVER_CONTAINER_NAME
