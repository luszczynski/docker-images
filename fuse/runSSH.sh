#!/bin/sh

. ../docker.properties

ssh root@$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' $FUSE_CONTAINER_NAME)


