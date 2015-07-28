#!/bin/sh
# from Docker official reference manual
# Note: I've written this using sh so it works in the busybox container too

# call the runtime setup
. /runtime_setup.sh

# USE the trap if you need to also do manual cleanup after the service is stopped,
#     or need to start multiple services in the one container
trap "echo TRAPed signal" HUP INT QUIT KILL TERM

# start service in background here
echo "starting Httpd service..."
$HTTPD_HOME/sbin/apachectl start

echo "starting RHQ Agent service..."
$RHQ_AGENT_HOME/bin/rhq-agent-wrapper.sh start 

echo "[hit enter key to exit] or run 'docker stop <container>'"
read

# stop service and clean up here
echo "stopping Httpd service"
$HTTPD_HOME/sbin/apachectl stop

echo "stoping RHQ Agent service..."
$RHQ_AGENT_HOME/bin/rhq-agent-wrapper.sh stop 

echo "exited $0"
