#!/bin/sh

# Script developed for starting eap standalone container.
#
# Gustavo Luszczynski <gluszczy@redhat.com>

. ../docker.sh

if [ "$#" = 0 ]; then
	usage
fi

case "$1" in
	start)
		startContainer "-p 127.0.0.1:9990:9990 -p 127.0.0.1:8080:8080" $STANDALONE_CONTAINER_NAME "$APACHE_CONTAINER_NAME,$JON_SERVER_CONTAINER_NAME" $STANDALONE_CONTAINER_NAME "$2"
	;;
	stop)
		stopContainer $STANDALONE_CONTAINER_NAME
	;;
	kill)
		killContainer $STANDALONE_CONTAINER_NAME
	;;
	log)
		logContainer $STANDALONE_CONTAINER_NAME
	;;
	ssh)
		sshContainer $STANDALONE_CONTAINER_NAME
	;;
	bash)
		bashContainer "" $STANDALONE_CONTAINER_NAME $STANDALONE_CONTAINER_NAME
	;;
	build)
		buildImage $STANDALONE_CONTAINER_NAME
	;;
	*)
		usage
esac