# Keycloak Docker Image

Keycloak Version: 1.0.2

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
Use to build Keycloak docker image.
This image is based on centos 6.
Before building this image, you must download `keycloak-appliance-dist-all-1.0.2.Final.zip` and put it in software folder.

## Keycloak
After running, you can access Keycloak console on http://127.0.0.1:8080/auth

User: admin

Password: admin

Keycloak folder: /opt/jboss/keycloak
