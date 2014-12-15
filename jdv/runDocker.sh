#!/bin/sh

# Script developed for starting JDV container.
#
# Gustavo Luszczynski <gluszczy@redhat.com>

. ../docker.sh

if [ "$#" -ne 1 ]; then
	usage
fi

case "$1" in
	start)
		startContainer "-p 127.0.0.1:9999:9999 -p 127.0.0.1:9990:9990 -p 127.0.0.1:31000:31000" $JDV_CONTAINER_NAME "" $JDV_CONTAINER_NAME
	;;
	stop)
		stopContainer $JDV_CONTAINER_NAME
	;;
	status)
		statusContainer $JDV_CONTAINER_NAME
	;;
	kill)
		killContainer $JDV_CONTAINER_NAME
	;;
	log)
		logContainer $JDV_CONTAINER_NAME
	;;
	attach)
		attachContainer) $JDV_CONTAINER_NAME
	;;
	bash)
		bashContainer "-p 127.0.0.1:9999:9999 -p 127.0.0.1:9990:9990" $JDV_CONTAINER_NAME $JDV_CONTAINER_NAME
	;;
	build)
		buildImage $JDV_CONTAINER_NAME
	;;
	*)
		usage
esac