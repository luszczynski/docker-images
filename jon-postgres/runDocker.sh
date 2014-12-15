#!/bin/sh

# Script developed for starting postgres
#
# Gustavo Luszczynski <gluszczy@redhat.com>

. ../docker.sh

case "$1" in
	start)
		startContainer "" $JON_POSTGRES_CONTAINER_NAME "$APACHE_CONTAINER_NAME,$JON_SERVER_CONTAINER_NAME" $JON_POSTGRES_CONTAINER_NAME
	;;
	stop)
		stopContainer $JON_POSTGRES_CONTAINER_NAME
	;;
	status)
		statusContainer $JON_POSTGRES_CONTAINER_NAME
	;;
	kill)
		killContainer $JON_POSTGRES_CONTAINER_NAME
	;;
	log)
		logContainer $JON_POSTGRES_CONTAINER_NAME
	;;
	attach)
		attachContainer) $JON_POSTGRES_CONTAINER_NAME
	;;
	bash)
		bashContainer "" $JON_POSTGRES_CONTAINER_NAME $JON_POSTGRES_CONTAINER_NAME
	;;
	build)
		buildImage $JON_POSTGRES_CONTAINER_NAME 
	;;
	*)
		usage
esac