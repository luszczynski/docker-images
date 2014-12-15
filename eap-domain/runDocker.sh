#!/bin/sh

# Script developed for starting EAP domain controller container.
#
# Gustavo Luszczynski <gluszczy@redhat.com>

. ../docker.sh

if [ "$#" -ne 1 ]; then
	usage
fi

case "$1" in
	start)
		startContainer "-p 127.0.0.1:9990:9990" $DOMAIN_CONTROLLER_CONTAINER_NAME "$APACHE_CONTAINER_NAME,$JON_SERVER_CONTAINER_NAME" $DOMAIN_CONTROLLER_CONTAINER_NAME
	;;
	stop)
		stopContainer $DOMAIN_CONTROLLER_CONTAINER_NAME
	;;
	status)
		statusContainer $DOMAIN_CONTROLLER_CONTAINER_NAME
	;;
	kill)
		killContainer $DOMAIN_CONTROLLER_CONTAINER_NAME
	;;
	log)
		logContainer $DOMAIN_CONTROLLER_CONTAINER_NAME
	;;
	attach)
		attachContainer) $DOMAIN_CONTROLLER_CONTAINER_NAME
	;;
	bash)
		bashContainer "-p 127.0.0.1:9990:9990" $DOMAIN_CONTROLLER_CONTAINER_NAME $DOMAIN_CONTROLLER_CONTAINER_NAME
	;;
	build)
		buildImage $DOMAIN_CONTROLLER_CONTAINER_NAME
	;;
	*)
		usage
esac