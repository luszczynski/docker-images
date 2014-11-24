#!/bin/sh

# Script developed for starting apache container.
#
# Gustavo Luszczynski <gluszczy@redhat.com>

. ../docker.sh

if [ "$#" -ne 1 ]; then
	usage
fi

case "$1" in
	start)
		startContainer "-p 127.0.0.1:80:80" $APACHE_CONTAINER_NAME "" $APACHE_CONTAINER_NAME
	;;
	stop)
		stopContainer $APACHE_CONTAINER_NAME
	;;
	kill)
		killContainer $APACHE_CONTAINER_NAME
	;;
	log)
		logContainer $APACHE_CONTAINER_NAME
	;;
	ssh)
		sshContainer $APACHE_CONTAINER_NAME
	;;
	bash)
		bashContainer "-p 127.0.0.1:80:80" $APACHE_CONTAINER_NAME $APACHE_CONTAINER_NAME
	;;
	build)
		buildImage $APACHE_CONTAINER_NAME
	;;
	*)
		usage
esac