#!/bin/sh

. ../docker.properties

sudo docker build -t centos6/$JON_SERVER_CONTAINER_NAME .
