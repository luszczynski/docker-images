#!/bin/bash

sudo docker stop $(sudo docker ps --filter 'status=running' | awk '{print $1}' | sed "1 d") 2>/dev/null
./cleanup.sh