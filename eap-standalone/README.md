# EAP Standalone Docker Image

EAP Version: 6.3.2

## runDocker.sh ( start | stop | kill | log | ssh | bash |build )

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
Use to build EAP Standalone docker image.
This image is based on centos 6.
Before building this image, you must download `jboss-eap-6.3.0.zip`, `jboss-eap-6.3.2-patch.zip` and `rhq-enterprise-agent-4.12.0.JON330GA.jar` and put them in software folder.

Ensure all JAR/ZIP have right permissions:
```
$ cd software
$ chmod o+r *.zip *.jar
```

## EAP
After running, you can access EAP Console on your localhost:9990.

User: admin

Password: redhat@123

EAP folder: /opt/jboss/eap

JON agent folder: /opt/jboss/jon

## JON Agent
There is a JON agent running inside this container. It will try to connect to JON server. If you want to play with JON Server, you must start it first so docker can create a connection between both containers.
