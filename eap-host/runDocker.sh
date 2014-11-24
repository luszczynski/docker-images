#!/bin/sh

# Script developed for starting host controller
#
# Gustavo Luszczynski <gluszczy@redhat.com>

. ../docker.sh

if [ "$#" -ne 2 ]; then
	usage "<host controller name>"
fi

case "$1" in
	start)
		startContainer "" $2 "$APACHE_CONTAINER_NAME,$DOMAIN_CONTROLLER_CONTAINER_NAME,$JON_SERVER_CONTAINER_NAME" $HOST_CONTAINER_NAME $2
	;;
	stop)
		stopContainer $2
	;;
	kill)
		killContainer $2
	;;
	log)
		logContainer $2
	;;
	ssh)
		sshContainer $2
	;;
	bash)
		bashContainer "" $HOST_CONTAINER_NAME HOST_CONTAINER_NAME
	;;
	build)
		buildImage $HOST_CONTAINER_NAME
	;;
	*)
		usage "<host controller name>"
esac