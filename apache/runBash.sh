#!/bin/sh

. ../docker.properties

sudo docker run -t -i --privileged -p 127.0.0.1:80:80 --rm --name $APACHE_CONTAINER_NAME centos6/$APACHE_CONTAINER_NAME /bin/bash



