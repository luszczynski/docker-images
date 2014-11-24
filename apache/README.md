# Apache Docker Image

Apache version: 2.2.15

mod_cluster version: 1.2.9 Final

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
Use to build apache docker image.
This image is based on centos 6.
Before building this image, you must download `jboss-eap-native-webserver-connectors-6.3.0-RHEL6-x86_64.zip` and put it in software folder.

## Mod_cluster
mod_cluster_manager is at: http://localhost/mod_cluster_manager