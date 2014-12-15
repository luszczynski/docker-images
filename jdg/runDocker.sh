#!/bin/sh

# Script developed for starting jdg container.
#
# Gustavo Luszczynski <gluszczy@redhat.com>

. ../docker.sh

if [ "$#" -ne 2 ]; then
	usage "<jdg instance name>"
fi

case "$1" in
	start)
		startContainer "" $2 "$APACHE_CONTAINER_NAME,$DOMAIN_CONTROLLER_CONTAINER_NAME,$JON_SERVER_CONTAINER_NAME,$STANDALONE_CONTAINER_NAME" $JDG_CONTAINER_NAME $2
	;;
	stop)
		stopContainer $2	
	;;
	status)
		statusContainer $2
	;;
	kill)
		killContainer $2
	;;
	log)
		logContainer $2
	;;
	attach)
		attachContainer) $2
	;;
	bash)
		bashContainer "" $JDG_CONTAINER_NAME $JDG_CONTAINER_NAME
	;;
	build)
		buildImage $JDG_CONTAINER_NAME
	;;
	*)
		usage "<jdg instance name>"
esac