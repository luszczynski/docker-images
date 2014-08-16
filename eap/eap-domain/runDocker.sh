#!/bin/sh

# Script developed for starting EAP domain controller container.
#
# Gustavo Luszczynski <gluszczy@redhat.com>

. ../../docker.properties

CMD_START="docker run --privileged --rm -p 127.0.0.1:9990:9990 --name $DOMAIN_CONTROLLER_CONTAINER_NAME";

APACHE_CONTAINER=$(sudo docker ps | grep $APACHE_CONTAINER_NAME)
if [ "x$APACHE_CONTAINER" != "x" ]; then
  CMD_START="$CMD_START --link $APACHE_CONTAINER_NAME:$APACHE_CONTAINER_NAME"
fi

JON_SERVER_CONTAINER=$(sudo docker ps | grep $JON_SERVER_CONTAINER_NAME)
if [ "x$JON_SERVER_CONTAINER" != "x" ]; then
  CMD_START="$CMD_START --link $JON_SERVER_CONTAINER_NAME:$JON_SERVER_CONTAINER_NAME"
fi

CMD_START="$CMD_START centos6/$DOMAIN_CONTROLLER_CONTAINER_NAME"

sudo $CMD_START;


