#!/bin/sh

# Script developed for starting postgres container.
#
# Gustavo Luszczynski <gluszczy@redhat.com>

. ../docker.sh

if [ "$#" -ne 1 ]; then
	usage
fi

case "$1" in
	start)
		startContainer "" $POSTGRESQL_CONTAINER_NAME "" $POSTGRESQL_CONTAINER_NAME
	;;
	stop)
		stopContainer $POSTGRESQL_CONTAINER_NAME
	;;
	status)
		statusContainer $POSTGRESQL_CONTAINER_NAME
	;;
	kill)
		killContainer $POSTGRESQL_CONTAINER_NAME
	;;
	log)
		logContainer $POSTGRESQL_CONTAINER_NAME
	;;
	attach)
		attachContainer $POSTGRESQL_CONTAINER_NAME
	;;
	bash)
		bashContainer "" $POSTGRESQL_CONTAINER_NAME $POSTGRESQL_CONTAINER_NAME
	;;
	build)
		buildImage $POSTGRESQL_CONTAINER_NAME
	;;
	*)
		usage
esac