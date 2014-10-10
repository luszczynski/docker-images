# Keycloak Docker Image

Keycloak Version: 1.0.2

## build.sh
Use to build Keycloak docker image.
This image is based on centos 6.
Before building this image, you must download `keycloak-appliance-dist-all-1.0.2.Final.zip` and put it in software folder.

## runBash.sh
Create a new Keycloak container running /bin/bash

## runSSH.sh
ssh into your running container.

password: redhat

## runDocker.sh
Create a new container running Keycloak.

### Keycloak
After running, you can access Keycloak console on http://127.0.0.1:8080/auth

User: admin

Password: admin

Keycloak folder: /opt/jboss/keycloak
