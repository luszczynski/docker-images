#!/bin/sh

. ../docker.properties

ssh root@$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' $JON_SERVER_CONTAINER_NAME)


