# Fuse Docker Image

Fuse version: 6.1.0

JON Agent Version: 3.3

## runDocker.sh ( start | stop | kill | log | ssh | bash | build )

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
Use to build fuse docker image.
This image is based on centos 6.
Before building this image, you must download `jboss-fuse-full-6.1.0.redhat-379.zip` and `rhq-enterprise-agent-4.12.0.JON330GA.jar` and put it in software folder.

## Fuse
After running, you can access fuse on your localhost:8181

user: admin

password: admin

## JON Agent
There is a JON agent running inside this container. It will try to connect to JON server. If you want to play with JON Server, you must start it first so docker can create a connection between both containers.