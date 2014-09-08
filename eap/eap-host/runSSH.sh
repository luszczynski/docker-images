#!/bin/sh

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 [host-controller name]"
  exit 1
fi

. ../../docker.properties

ssh root@$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' $1)


