# JON Server Docker Image

JON Server Version: 3.3

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
Use to build JON Server docker image.
This image is based on centos 6.
Before building this image, you must download `jon-server-3.3.0.GA.zip` and all jon plugins and put them in software folder.

## JON Server
After running, you can access JON GUI on your localhost:7080.

User: rhqadmin

Password: rhqadmin

To avoid 
```Got agent registration request for existing agent: 172.17.0.11 172.17.0.11:16163 4.9.0.JON320GA(734bd56) - Will not regenerate a new token```
Go to Administration -> Servers -> jon-server

And change `Endpoint Address` to `jon-server`

Click save.

JON folder: /opt/jboss/jon
