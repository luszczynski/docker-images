# JON Server Docker Image

JON Server Version: 3.2

Postgresql Version: 8.4

## build.sh
Use to build JON Server docker image.
This image is based on centos 6.
Before building this image, you must download `jon-server-3.2.0.GA.zip`, `jon-plugin-pack-eap-3.2.0.GA.zip` and put them in software folder.

## runBash.sh
Create a new JON Server container running /bin/bash

## runSSH.sh
ssh into your running container.

password: redhat

## runDocker.sh
Create a new container running JON Server.

### JON Server
After running, you can access JON GUI on your localhost:7080.

User: rhqadmin

Password: rhqadmin

To avoid 
```Got agent registration request for existing agent: 172.17.0.11 172.17.0.11:16163 4.9.0.JON320GA(734bd56) - Will not regenerate a new token```
Go to Administration -> Servers -> jon-server

And change `Endpoint Address` to `jon-server`

Click save.

JON folder: /opt/jboss/jon
