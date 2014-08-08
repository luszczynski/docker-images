#!/bin/sh

. ../docker.properties

sudo docker run -t -i --privileged --rm --name $JON_SERVER_CONTAINER_NAME centos6/$JON_SERVER_CONTAINER_NAME /bin/bash
