# EAP Host Controller Docker Image

EAP Version: 6.3.1

JON Version: 3.2

## build.sh
Use to build EAP Host controller image.
This image is based on centos 6.
Before building this image, you must download `jboss-eap-6.3.0.zip`, `jboss-eap-6.3.1-patch.zip` and `rhq-enterprise-agent-4.9.0.JON320GA.jar` and put them in software folder.

Ensure all JAR/ZIP have right permissions:
```
$ cd software
$ chmod o+r *.zip *.jar
```
## runBash.sh
Create a new EAP Host Controller container running /bin/bash

## runSSH.sh
ssh into your running container.

password: redhat

## runDocker.sh
Create a new container running EAP Host Controller and JON Agent.

### EAP
After running, EAP host controller will try to connect to eap-domain. So, be sure you have started eap-domain first.
Remember you need to give a name for each host controller container. Therefore, you can have as many host controller as you want.

### JON Agent
There is a jon agent running inside this container. It will try to connect to jon-server. So, it is mandatory to start first jon-server container so docker can link with it.
