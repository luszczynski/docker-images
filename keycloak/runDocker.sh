#!/bin/sh

# Script developed for starting keycloak container.
#
# Gustavo Luszczynski <gluszczy@redhat.com>

. ../docker.sh

if [ "$#" -ne 1 ]; then
	usage
fi

case "$1" in
	start)
		startContainer "-p 127.0.0.2:8080:8080 -p 127.0.0.2:9990:9990" $KEYCLOAK_CONTAINER_NAME "$APACHE_CONTAINER_NAME" $KEYCLOAK_CONTAINER_NAME
	;;
	stop)
		stopContainer $KEYCLOAK_CONTAINER_NAME
	;;
	kill)
		killContainer $KEYCLOAK_CONTAINER_NAME
	;;
	log)
		logContainer $KEYCLOAK_CONTAINER_NAME
	;;
	ssh)
		sshContainer $KEYCLOAK_CONTAINER_NAME
	;;
	bash)
		bashContainer "-p 127.0.0.1:8080:8080" $KEYCLOAK_CONTAINER_NAME $KEYCLOAK_CONTAINER_NAME
	;;
	build)
		buildImage $KEYCLOAK_CONTAINER_NAME
	;;
	*)
		usage
esac