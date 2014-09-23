#!/bin/sh

# Script developed for starting bpms container.
#
# Gustavo Luszczynski <gluszczy@redhat.com>

. ../docker.properties

CMD_START="docker run --rm -p 127.0.0.1:8080:8080 -p 127.0.0.1:9990:9990 --privileged --name $BPMS_CONTAINER_NAME";

isApache=$(sudo docker ps | grep $APACHE_CONTAINER_NAME)
test "x$isApache" = "x" || CMD_START="$CMD_START --link $APACHE_CONTAINER_NAME:$APACHE_CONTAINER_NAME"

isJON=$(sudo docker ps | grep $JON_SERVER_CONTAINER_NAME)
test "x$isJON" = "x" || CMD_START="$CMD_START --link $JON_SERVER_CONTAINER_NAME:$JON_SERVER_CONTAINER_NAME"

CMD_START="$CMD_START $DOCKER_USER/centos6-$BPMS_CONTAINER_NAME $1"

sudo $CMD_START;

#sudo docker run --rm -p 127.0.0.1:8080:8080 --name $BPMS_CONTAINER_NAME $DOCKER_USER/centos6-$BPMS_CONTAINER_NAME


