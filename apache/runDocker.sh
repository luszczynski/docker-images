#!/bin/sh

. ../docker.properties

sudo docker run --privileged --rm -p 127.0.0.1:80:80 --name $APACHE_CONTAINER_NAME centos6/$APACHE_CONTAINER_NAME
