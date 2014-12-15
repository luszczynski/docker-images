#!/bin/sh

# Script developed for starting jon server container.
#
# Gustavo Luszczynski <gluszczy@redhat.com>

. ../docker.sh

if [ "$#" -ne 1 ]; then
	usage
fi

case "$1" in
	start)
		startContainer "-p 127.0.0.1:7080:7080" $JON_SERVER_CONTAINER_NAME "$APACHE_CONTAINER_NAME,$JON_POSTGRES_CONTAINER_NAME" $JON_SERVER_CONTAINER_NAME
	;;
	stop)
		stopContainer $JON_SERVER_CONTAINER_NAME
	;;
	status)
		statusContainer $JON_SERVER_CONTAINER_NAME
	;;
	kill)
		killContainer $JON_SERVER_CONTAINER_NAME
	;;
	log)
		logContainer $JON_SERVER_CONTAINER_NAME
	;;
	attach)
		attachContainer) $JON_SERVER_CONTAINER_NAME
	;;
	bash)
		bashContainer "-p 127.0.0.1:7080:7080" $JON_SERVER_CONTAINER_NAME $JON_SERVER_CONTAINER_NAME
	;;
	build)
		buildImage $JON_SERVER_CONTAINER_NAME
	;;
	*)
		usage
esac


