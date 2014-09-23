# BPMS Docker Image

BPMS Version: 6.0.2

JON Agent Version: 3.2

## build.sh
Use to build BPMS docker image.
This image is based on centos 6.
Before building this image, you must download `jboss-bpms-6.0.2.GA-redhat-5-deployable-eap6.x.zip`, `jboss-eap-6.1.1.zip` and `rhq-enterprise-agent-4.9.0.JON320GA.jar` and put them in software folder.

## runBash.sh
Create a new BPMS container running /bin/bash

## runSSH.sh
ssh into your running container.

password: redhat

## runDocker.sh
Create a new container running BPMS and JON Agent.

### BPMS
After running, you can access BPMS Business Central on http://127.0.0.1:8080/business-central

User: admin

Password: redhat@123

BPMS folder: /opt/jboss/bpms

JON agent folder: /opt/jboss/jon

### JON Agent
There is a jon agent running inside this container. It will try to connect to jon-server. So, it is mandatory to start first jon-server container so docker can link with it.
