#!/bin/sh

. ../docker.properties

ssh root@$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' $APACHE_CONTAINER_NAME)


