#!/bin/sh

# Gustavo Luszczynski <gluszczy@redhat.com>

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

. ./docker.sh


function cleanup() {
	docker rmi $(docker images | grep "^<none>" | awk '{print $3}') 2>/dev/null
	docker rm $(docker ps -a | awk '{print $1}' | sed "1 d") 2>/dev/null
}

function updateDNS() {
	# Backup
	cp /etc/resolv.conf{,.orig}

	# create resolv.conf
	echo "nameserver $1" > /etc/resolv.conf
	echo "nameserver 8.8.8.8" >> /etc/resolv.conf
}

# $1: Parameters
# $2: Container name
# $3: Image name
# $4: Container parameter
function startContainer() {
	cleanup 1> /dev/null

	IP_DNS=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $DNSMASQ_CONTAINER_NAME 2> /dev/null)
	
        if [ "x$IP_DNS" == "x" ]; then
		echo "dnsmasq not started. Starting now..."
		docker run --privileged -d --name $DNSMASQ_CONTAINER_NAME -h $DNSMASQ_CONTAINER_NAME $DOCKER_USER/$OS_CONTAINER-$DNSMASQ_CONTAINER_NAME 2> /dev/null
		IP_DNS=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $DNSMASQ_CONTAINER_NAME)

		updateDNS "$IP_DNS"
	fi

	CMD_START="docker run --privileged $1 -d --name $2 --volumes-from $DNSMASQ_CONTAINER_NAME --dns $IP_DNS -v /etc/timezone:/etc/timezone:ro -v /tmp/share:/tmp/share";

	if [ "x$4" == "x" ]; then
		CMD_START="$CMD_START -h $2"
	else
		CMD_START="$CMD_START -h $4"
	fi

	CMD_START="$CMD_START $DOCKER_USER/$OS_CONTAINER-$3 $4"
#read
	$CMD_START;
	
}

function stopContainer() {
	docker stop $1
	cleanup
}

function stopAll() {
	docker stop $(docker ps --filter 'status=running' | awk '{print $1}' | sed "1 d") 2>/dev/null
	cleanup
}

function statusContainer() {
	status=$(docker ps | grep $1 2> /dev/null)

	if [ "x$status" == "x" ]; then
		echo "Container is NOT running"
	else
		echo "Container is running"
	fi
}

function killContainer() {
	docker kill $1
	cleanup
}

function killAll() {
	docker kill $(docker ps --filter 'status=running' | awk '{print $1}' | sed "1 d") 2>/dev/null
	cleanup
}

function logContainer() {
	docker logs -f $1
}

function attachContainer() {
	docker exec -it $1 bash
}

function bashContainer() {
	docker run -ti --privileged $1 --rm --name $2 $DOCKER_USER/$OS_CONTAINER-$3 /bin/bash
}

# $1 image name
# $2 path to Dockerfile
function buildImage() {
	PARAM=$1

	[[ $1 != $OS_CONTAINER* ]] || PARAM=$(echo $1 | cut -d "-" -f2,3)

	docker build --rm=true --force-rm=true -t $DOCKER_USER/$OS_CONTAINER-$PARAM $2
	cleanup
}

function buildAll() {
	base_images=$(ls base)
	for image in $base_images; do
		CONTAINER_DIR=$(find . -name "$image" | sed 's/.\///')
		buildImage $image $CONTAINER_DIR
	done

	products_images=$(ls products)
	for image in $products_images; do
		CONTAINER_DIR=$(find . -name "$image" | sed 's/.\///')
		buildImage $image $CONTAINER_DIR
	done

	demo_images=$(ls demos)
	for image in $demo_images; do
		CONTAINER_DIR=$(find . -name "$image" | sed 's/.\///')
		buildImage $image $CONTAINER_DIR
	done
}

function resume() {
	echo	
}

function removeAllImages() {
	docker rmi $(docker images | grep $DOCKER_USER | awk '{print $1}')
}

function usage() {
	  echo
	  echo "Usage: $0 ( start | stop | status | kill | log | attach | bash | build ) <image name> <instance name>"
	  echo "Usage: $0 ( stopall | killall | buildall | clean | removeimages )"
	  echo "============================================="
	  echo
	  echo "start 	<image name> <instance name>			start container"
	  echo "stop 	<instance name>					stop container"
	  echo "kill 	<instance name>					kill container"
	  echo "status 	<instance name>					show if container is running or not"
	  echo "log 	<instance name>					show container standard output"
	  echo "attach 	<instance name>					access container (similar to ssh)"
	  echo "bash 	<image name>					start container running /bin/bash"
	  echo "build 	<image name>					build container image"
	  echo
	  echo "<image name> is equal to Dockerfile's folder name."
	  echo "<instance name> is the name you give to your container."
	  echo "If none is set then instance name will be image name. Only some images accept random names (eap-host and jdg)"
	  echo 
	  echo "eg: 	$0 start eap-domain"
	  echo "	$0 log eap-domain"
	  echo "eg2: 	$0 start eap-host host01"
	  echo "	$0 attach host01"
	  echo "eg3: 	$0 start eap-host host02"
	  echo "	$0 kill host02"
	  echo
	  echo
	  echo "Usage: $0 ( stopall | killall | buildall | clean | removeimages )"
	  echo "=============================================="
	  echo
	  echo "stopall 					stop all containers"
	  echo "killall 					kill all containers"
	  echo "buildall 					build all images"
	  echo "clean 						remove stopped containers (docker ps -a)"
	  echo "removeimages 					remova all ${DOCKER_USER}'s images"
	  exit 0
}

if [ "$#" == 0 ] ; then
	usage
	exit 1
fi

# Container Operation System
OS_CONTAINER="centos7"

# Path to container
CONTAINER_DIR=$(find . -name "$2" | sed 's/.\///')

# Image name. It's the same name of the container dir
IMAGE_NAME=$(echo $CONTAINER_DIR | awk -F/ '{ print $NF }')

# Instance name. Only used when image support multiples instances
INSTANCE_NAME=$(docker ps | grep "$2" | awk -F" " '{print $NF}')

MULTIPLE_INSTANCE=false

if [ "x$3" != "x" ]; then
	MULTIPLE_INSTANCE=true
fi

case "$1" in
	start)
		if [ $MULTIPLE_INSTANCE == true ]; then
			startContainer "$CMD_LINE" $3 $IMAGE_NAME $3
		else
			startContainer "$CMD_LINE" $IMAGE_NAME $IMAGE_NAME
		fi
	;;
	stop)
		if [ $MULTIPLE_INSTANCE == true ]; then
			stopContainer $3
		else
			stopContainer $INSTANCE_NAME
		fi
	;;
	resume)
		resume $INSTANCE_NAME
	;;
	status)
		if [ $MULTIPLE_INSTANCE == true ]; then
			statusContainer $3
		else
			statusContainer $INSTANCE_NAME
		fi
	;;
	kill)
		if [ $MULTIPLE_INSTANCE == true ]; then
			killContainer $3
		else
			killContainer $INSTANCE_NAME
		fi
	;;
	log)		
			logContainer $2
	;;
	attach)
		if [ $MULTIPLE_INSTANCE == true ]; then
			attachContainer $3
		else
			attachContainer $INSTANCE_NAME
		fi
	;;
	bash)
		if [ $MULTIPLE_INSTANCE == true ]; then
			bashContainer "$CMD_LINE" $3 $IMAGE_NAME
		else
			bashContainer "$CMD_LINE" $IMAGE_NAME $IMAGE_NAME
		fi
	;;
	build)
		buildImage $IMAGE_NAME $CONTAINER_DIR
	;;
	stopall)
		stopAll
	;;
	killall)
		killAll
	;;
	buildall)
		buildAll
	;;
	clean)
		cleanup
	;;
	removeimages)
		removeAllImages
	;;
	--help)
		usage
	;;
	*)
		usage
esac
