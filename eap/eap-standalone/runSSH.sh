#!/bin/sh

. ../../docker.properties

ssh root@$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' $STANDALONE_CONTAINER_NAME)


