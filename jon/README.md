# JON Server Docker Image

JON Server Version: 3.2

Postgresql Version: 9.2

## build.sh
Use to build JON Server docker image.
This image is based on centos 6.
Before building this image, you must download jon-server-3.2.0.GA.zip, jon-plugin-pack-eap-3.2.0.GA.zip and put them in software folder.

## runBash.sh
Create a new JON Server container running /bin/bash

## runDocker.sh
Create a new container running JON Server.

### JON Server
After running, you can access JON GUI on your localhost:7080.
User: rhqadmin
Password: rhqadmin

### SSH
Also, you can ssh into container using user root and password redhat.
To check ip address use docker inspect --format '{{ .NetworkSettings.IPAddress }}' jon-server.
