#!/bin/sh

. ../docker.properties

ssh root@$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' $BPMS_CONTAINER_NAME)


