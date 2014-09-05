# EAP Host Controller Docker Image

EAP Version: 6.3

JON Version: 3.2

## build.sh
Use to build EAP Domain docker image.
This image is based on centos 6.
Before building this image, you must download jboss-eap-6.3.0.zip and rhq-enterprise-agent-4.9.0.JON320GA.jar and put them in software folder.

## runBash.sh
Create a new EAP Host Controller container running /bin/bash

## runDocker.sh
Create a new container running EAP Host Controller and JON Agent

### EAP
After running, EAP host controller will try to connect to eap-domain. So, be sure you have started eap-domain first.
Remember you need to give a name for each host controller container. Therefore, you can have as many host controller as you want.

### JON Agent
There is a jon agent running inside this container. It will try to connect to jon-server. So, it is mandatory to start first jon-server container so docker can link with it.

### SSH
Also, you can ssh into container using user root and password redhat.
To check ip address use docker inspect --format '{{ .NetworkSettings.IPAddress }}' {host controller name}.
