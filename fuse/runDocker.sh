#!/bin/sh

# Script developed for starting fuse container.
#
# Gustavo Luszczynski <gluszczy@redhat.com>

. ../docker.sh

if [ "$#" -ne 1 ]; then
  usage
fi

case "$1" in
	start)
		startContainer "-p 127.0.0.1:8181:8181" $FUSE_CONTAINER_NAME "$APACHE_CONTAINER_NAME,$JON_SERVER_CONTAINER_NAME" $FUSE_CONTAINER_NAME
	;;
	stop)
		stopContainer $FUSE_CONTAINER_NAME
	;;
	kill)
		killContainer $FUSE_CONTAINER_NAME
	;;
	log)
		logContainer $FUSE_CONTAINER_NAME
	;;
	ssh)
		sshContainer $FUSE_CONTAINER_NAME
	;;
	bash)
		bashContainer "-p 127.0.0.1:8181:8181" $FUSE_CONTAINER_NAME $FUSE_CONTAINER_NAME
	;;
	build)
		buildImage $FUSE_CONTAINER_NAME
	;;
	*)
		usage
esac

