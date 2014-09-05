# Apache Docker Image

Apache version: 2.2.15
mod_cluster version: 1.2.9 Final

## build.sh
Use to build apache docker image.
This image is based on centos 6.

## runBash.sh
Create a new apache container running /bin/bash

## runDocker.sh
Create a new container running apache with mod_cluster.
After running, you can access apache on your localhost.
mod_cluster_manager is at: http://localhost/mod_cluster_manager.

Also, you can ssh into container using user root and password redhat.
To check ip address use docker inspect --format '{{ .NetworkSettings.IPAddress }}' apache.
