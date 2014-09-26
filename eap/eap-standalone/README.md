# EAP Standalone Docker Image

EAP Version: 6.3.1

## build.sh
Use to build EAP Standalone docker image.
This image is based on centos 6.
Before building this image, you must download `jboss-eap-6.3.0.zip`, `jboss-eap-6.3.1-patch.zip` and `rhq-enterprise-agent-4.9.0.JON320GA.jar` and put them in software folder.

Ensure all JAR/ZIP have right permissions:

$ cd software
$ chmod o+r *.zip *.jar

## runBash.sh
Create a new EAP Standalone container running /bin/bash

## runSSH.sh
ssh into your running container.

password: redhat

## runDocker.sh
Create a new container running EAP Standalone and JON Agent

### EAP
After running, you can access EAP Console on your localhost:9990.

User: admin

Password: redhat@123

EAP folder: /opt/jboss/eap

JON agent folder: /opt/jboss/jon

### JON Agent
There is a jon agent running inside this container. It will try to connect to jon-server. So, it is mandatory to start first jon-server container so docker can link with it.
