#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 (start|stop)"
  exit 1
fi

. docker.properties

case "$1" in
	start)
		./cleanup.sh
		
		cd apache
		./runDocker.sh

		cd ../jon
		./runDocker.sh

		cd ../eap/eap-domain
		./runDocker.sh

		cd ../eap-host
		./runDocker.sh host01

		cd ../eap-host
		./runDocker.sh host02	
	;;
	stop)
		sudo docker stop $DOMAIN_CONTROLLER_CONTAINER_NAME $APACHE_CONTAINER_NAME $JON_SERVER_CONTAINER_NAME host01 host02
		./cleanup.sh
	;;
	*)
		echo "Usage: $0 [start|stop]"
		exit 1
esac


