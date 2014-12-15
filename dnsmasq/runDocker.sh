#!/bin/sh

# Script developed for starting dnsmasq container.
#
# Gustavo Luszczynski <gluszczy@redhat.com>

. ../docker.sh

CONTAINER_NAME=$DNSMASQ_CONTAINER_NAME
MENU=false

if [ "$#" -ne 1 ]; then
	usage
fi

case "$1" in
	start)
		sudo docker run --privileged -d --name $DNSMASQ_CONTAINER_NAME -h $DNSMASQ_CONTAINER_NAME $DOCKER_USER/centos7-$DNSMASQ_CONTAINER_NAME
	;;
	stop)
		stopContainer $DNSMASQ_CONTAINER_NAME
	;;
	status)
		statusContainer $DNSMASQ_CONTAINER_NAME
	;;
	kill)
		killContainer $DNSMASQ_CONTAINER_NAME
	;;
	log)
		logContainer $DNSMASQ_CONTAINER_NAME
	;;
	attach)
		attachContainer) $DNSMASQ_CONTAINER_NAME
	;;
	bash)
		bashContainer "" $DNSMASQ_CONTAINER_NAME $DNSMASQ_CONTAINER_NAME
	;;
	build)
		buildImage $DNSMASQ_CONTAINER_NAME
	;;
	*)
		usage
esac