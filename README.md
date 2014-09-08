# JBoss Docker Images

Here we have some jboss docker images.
If you want to play, remember there is an order that you should run each container (see below):

1. Apache

2. JON Server

3. EAP Domain

4. Host controller

This order is due the way docker links containers. According Docker documentation, you can only link one container with another that is already running.

## Build
You have to build each image. To do so, enter each directory and run build.sh.

Enjoy!
