#!/bin/sh

# Script developed for starting mysql container.
#
# Gustavo Luszczynski <gluszczy@redhat.com>

. ../docker.sh

if [ "$#" -ne 1 ]; then
	usage
fi

case "$1" in
	start)
		startContainer "" $MYSQL_CONTAINER_NAME "" $MYSQL_CONTAINER_NAME
	;;
	stop)
		stopContainer $MYSQL_CONTAINER_NAME
	;;
	status)
		statusContainer $MYSQL_CONTAINER_NAME
	;;
	kill)
		killContainer $MYSQL_CONTAINER_NAME
	;;
	log)
		logContainer $MYSQL_CONTAINER_NAME
	;;
	attach)
		attachContainer $MYSQL_CONTAINER_NAME
	;;
	bash)
		bashContainer "" $MYSQL_CONTAINER_NAME $MYSQL_CONTAINER_NAME
	;;
	build)
		buildImage $MYSQL_CONTAINER_NAME
	;;
	*)
		usage
esac