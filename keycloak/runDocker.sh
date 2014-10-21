#!/bin/sh

# Script developed for starting keycloak container.
#
# Gustavo Luszczynski <gluszczy@redhat.com>

. ../docker.properties

CMD_START="docker run --rm -p 127.0.0.2:8080:8080 -p 127.0.0.2:9990:9990 --privileged --name $KEYCLOAK_CONTAINER_NAME";

isApache=$(sudo docker ps | grep $APACHE_CONTAINER_NAME)
test "x$isApache" = "x" || CMD_START="$CMD_START --link $APACHE_CONTAINER_NAME:$APACHE_CONTAINER_NAME"

CMD_START="$CMD_START $DOCKER_USER/centos6-$KEYCLOAK_CONTAINER_NAME $1"

sudo $CMD_START;

#sudo docker run --rm -p 127.0.0.1:8080:8080 --name $KEYCLOAK_CONTAINER_NAME $DOCKER_USER/centos6-$KEYCLOAK_CONTAINER_NAME


