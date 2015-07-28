#!/bin/sh

# call the runtime setup
. /runtime_setup.sh

# set the agent properties in a way it don't need a static agent-configuration.xml
export RHQ_AGENT_HOME=/opt/redhat/rhq-agent
export RHQ_JAVA_HOME=$JAVA_HOME
export RHQ_AGENT_DEBUG=true
export RHQ_AGENT_ADDITIONAL_JAVA_OPTS="-Drhq.agent.configuration-setup-flag=true -Drhq.agent.name=$HOSTNAME -Drhq.agent.server.bind-address=jon-server -Drhq.agent.server-auto-detection=true -Drhq.communications.multicast-detector.enabled=true -Drhq.agent.wait-for-server-at-startup-msecs=600000"

# USE the trap if you need to also do manual cleanup after the service is stopped,
#     or need to start multiple services in the one container
trap "echo TRAPed signal" HUP INT QUIT KILL TERM

# start service in background here
echo "starting RHQ Agent service..."
$RHQ_AGENT_HOME/bin/rhq-agent-wrapper.sh start

# call the centos-postgresql base image' startup script
/start_postgres.sh

echo "[hit enter key to exit] or run 'docker stop <container>'"
read

echo "stoping RHQ Agent service..."
$RHQ_AGENT_HOME/bin/rhq-agent-wrapper.sh stop

echo "exited $0"


