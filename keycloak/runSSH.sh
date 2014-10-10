#!/bin/sh

. ../docker.properties

ssh root@$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' $KEYCLOAK_CONTAINER_NAME)


