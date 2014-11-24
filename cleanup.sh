#!/bin/bash

sudo docker rmi $(sudo docker images | grep "^<none>" | awk '{print $3}') 2>/dev/null
sudo docker rm $(sudo docker ps -a | awk '{print $1}' | sed "1 d") 2>/dev/null
