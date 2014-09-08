#!/bin/sh

. ../../docker.properties

ssh root@$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' $DOMAIN_CONTROLLER_CONTAINER_NAME)


