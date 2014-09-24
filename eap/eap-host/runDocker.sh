#!/bin/sh

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 [host-controller name]"
  exit 1
fi

. ../../docker.properties

CMD_START="docker run -d --privileged --name $1";

isApache=$(sudo docker ps | grep $APACHE_CONTAINER_NAME)
test "x$isApache" = "x" || CMD_START="$CMD_START --link $APACHE_CONTAINER_NAME:$APACHE_CONTAINER_NAME"

isEAP=$(sudo docker ps | grep $DOMAIN_CONTROLLER_CONTAINER_NAME)
test "x$isEAP" = "x" || CMD_START="$CMD_START --link $DOMAIN_CONTROLLER_CONTAINER_NAME:$DOMAIN_CONTROLLER_CONTAINER_NAME"

isJON=$(sudo docker ps | grep $JON_SERVER_CONTAINER_NAME)
test "x$isJON" = "x" || CMD_START="$CMD_START --link $JON_SERVER_CONTAINER_NAME:$JON_SERVER_CONTAINER_NAME"

CMD_START="$CMD_START $DOCKER_USER/centos6-$HOST_CONTAINER_NAME $1"

sudo $CMD_START;

#sudo docker logs -f $1
