#!/bin/bash

# increase the OS file descritors limits
echo "* soft nofile 4096" >> /etc/security/limits.conf 
echo "* hard nofile 4096" >> /etc/security/limits.conf

#useradd -m -d /home/jboss -p jboss jboss

# set the root's pwd
echo 'root:redhat' | chpasswd
