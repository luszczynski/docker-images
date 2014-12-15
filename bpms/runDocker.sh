#!/bin/sh

# Script developed for starting bpms container.
#
# Gustavo Luszczynski <gluszczy@redhat.com>

. ../docker.sh
	
if [ "$#" -ne 1 ]; then
	usage
fi

case "$1" in
	start)
		startContainer "-p 127.0.0.1:8080:8080 -p 127.0.0.1:9990:9990" $BPMS_CONTAINER_NAME "" $BPMS_CONTAINER_NAME
	;;
	stop)
		stopContainer $BPMS_CONTAINER_NAME
	;;
	status)
		statusContainer $BPMS_CONTAINER_NAME
	;;
	kill)
		killContainer $BPMS_CONTAINER_NAME
	;;
	log)
		logContainer $BPMS_CONTAINER_NAME
	;;
	attach)
		attachContainer $BPMS_CONTAINER_NAME
	;;
	bash)
		bashContainer "-p 127.0.0.1:8080:8080 -p 127.0.0.1:9990:9990" $BPMS_CONTAINER_NAME $BPMS_CONTAINER_NAME
	;;
	build)
		buildImage $BPMS_CONTAINER_NAME
	;;
	*)
		usage
esac