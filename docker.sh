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
JDG_NODE01_NAME="node01"
KEYCLOAK_CONTAINER_NAME="keycloak-server"
DOCKER_USER="luszczynski"

function usage() {
	  echo "Usage: $0 ( start | stop | kill | log | ssh | bash | build ) $1"
	  exit 1
}

# $1: Parameters
# $2: Container name
# $3: link:<container name1, container name2>
# $4: Image name
function startContainer() {

	CMD_START="sudo docker run --privileged $1 -d --name $2";

	OLDIFS=$IFS
	IFS=',' read -a array <<< "$3"

	for containerName in "${array[@]}"
	do
		isContainerRunning=$(sudo docker ps | grep $containerName)
		test "x$isContainerRunning" = "x" || CMD_START="$CMD_START --link $containerName:$containerName"
	done

	IFS=$OLDIFS

	CMD_START="$CMD_START $DOCKER_USER/centos6-$4 $5"

	sudo $CMD_START;
	
}

function stopContainer() {
	sudo docker stop $1
	../cleanup.sh
}

function killContainer() {
	sudo docker kill $1
	../cleanup.sh
}

function logContainer() {
	sudo docker logs -f $1
}

function sshContainer() {
	sudo docker exec -it $1 bash
}

function bashContainer() {
	sudo docker run -ti --privileged $1 --rm --name $2 $DOCKER_USER/centos6-$3 /bin/bash
}

function buildImage() {
	sudo docker build --rm=true --force-rm=true -t $DOCKER_USER/centos6-${1} .
	../cleanup.sh
}