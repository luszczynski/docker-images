# EAP Host Controller Docker Image

Postgres Version: 8.4

JON Version: 3.3

## runDocker.sh ( start | stop | kill | log | ssh | bash )

**start:**
Start container

**stop:**
Stop your container gracefully

**kill:**
Kill your container

**log:**
Show container's log

**ssh:**
SSH into your running container. (Requires docker 1.3+)

**bash:**
Create a new container running bash

**build**
Use to build postgres image.
This image is based on centos 6.

## JON Agent
There is a JON agent running inside this container. It will try to connect to JON server. If you want to play with JON Server, you must start it first so docker can create a connection between both containers.
