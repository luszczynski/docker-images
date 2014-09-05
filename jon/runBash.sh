#!/bin/sh

. ../docker.properties

sudo docker run -t -i --privileged --rm --name $JON_SERVER_CONTAINER_NAME $DOCKER_USER/centos6-$JON_SERVER_CONTAINER_NAME /bin/bash
