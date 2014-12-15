#!/bin/bash

DOMAIN_CONTROLLER_CONTAINER_NAME="eap-domain"
APACHE_CONTAINER_NAME="apache"
JON_SERVER_CONTAINER_NAME="jon-server"
JON_POSTGRES_CONTAINER_NAME="jon-postgres"
HOST_CONTAINER_NAME="eap-host"
STANDALONE_CONTAINER_NAME="eap-standalone"
MYSQL_CONTAINER_NAME="mysql-server"
POSTGRESQL_CONTAINER_NAME="postgresql-server"
FUSE_CONTAINER_NAME="fuse"
BPMS_CONTAINER_NAME="bpms"
JDG_CONTAINER_NAME="jdg"
JDV_CONTAINER_NAME="jdv"
JDG_NODE01_NAME="node01"
KEYCLOAK_CONTAINER_NAME="keycloak-server"
DNSMASQ_CONTAINER_NAME="dnsmasq"
DOCKER_USER="luszczynski"

function usage() {
	  echo "Usage: $0 ( start | stop | status | kill | log | attach | bash | build ) $1"
	  exit 1
}

# $1: Parameters
# $2: Container name
# $3: link:<container name1, container name2>
# $4: Image name
function startContainer() {
	IP_DNS=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' $DNSMASQ_CONTAINER_NAME 2> /dev/null)

	if [ "x$IP_DNS" == "x" ]; then
		echo "dnsmasq not started."
		echo "starting now..."
		../dnsmasq/runDocker.sh start
		
		IP_DNS=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' $DNSMASQ_CONTAINER_NAME)		
	fi

	CMD_START="sudo docker run --privileged $1 -d --name $2 --volumes-from $DNSMASQ_CONTAINER_NAME --dns $IP_DNS -v /etc/timezone:/etc/timezone:ro -v /tmp/share:/tmp/share";

	if [ "x$5" == "x" ]; then
		CMD_START="$CMD_START -h $2"
	else
		CMD_START="$CMD_START -h $5"
	fi

	CMD_START="$CMD_START $DOCKER_USER/centos7-$4 $5"

	sudo $CMD_START;
	
}

function stopContainer() {
	sudo docker stop $1
	../cleanup.sh
}

function statusContainer() {
	status=$(sudo docker ps | grep $1 2> /dev/null)

	if [ "x$status" == "x" ]; then
		echo "Container is NOT running"
	else
		echo "Container is running"
	fi
}

function killContainer() {
	sudo docker kill $1
	../cleanup.sh
}

function logContainer() {
	sudo docker logs -f $1
}

function attachContainer() {
	sudo docker exec -it $1 bash
}

function bashContainer() {
	sudo docker run -ti --privileged $1 --rm --name $2 $DOCKER_USER/centos7-$3 /bin/bash
}

function buildImage() {
	sudo docker build --rm=true --force-rm=true -t $DOCKER_USER/centos7-${1} .
	../cleanup.sh
}