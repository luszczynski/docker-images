#!/bin/bash
set -e
#IP_ADDR=$(ip a s | sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}')
CONTAINER_IP_ADDR=$(ip a s | sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}')

# call the runtime setup
#. /runtime_setup.sh

# USE the trap if you need to also do manual cleanup after the service is stopped,
#     or need to start multiple services in the one container
#trap "echo TRAPed signal" HUP INT QUIT KILL TERM

# some properties to avoid JGroups issues when using cluster/ha profiles
JAVA_OPTS="-Djboss.node.name=$HOSTNAME -Djgroups.bind_addr=$CONTAINER_IP_ADDR"
# when using mod_cluster, change the default node name
JAVA_OPTS="$JAVA_OPTS -Djboss.mod_cluster.jvmRoute=$HOSTNAME -DjvmRoute=$HOSTNAME"
export JAVA_OPTS

EAP_RUNTIME_MODE="${1:-standalone}"

# check the startup mode specified (defaults to standalone)
if [ "$EAP_RUNTIME_MODE" == 'standalone' ]
then
   echo -e "\n\t >>> starting JBoss EAP $EAP_VERSION in Standalone mode with full profile (HA support) <<< \n"
   echo -e "\t\t using the IP $CONTAINER_IP_ADDR "
   echo -e "\t\t startup parameters passed to conatiner: [$@] "
   
   ADDITIONAL_PARAMS=" "
   [[ "$#" -gt 1  ]] && ADDITIONAL_PARAMS=${@:2}
   
   echo -e "\t\t JBoss startup ADDITIONAL parameters: [$ADDITIONAL_PARAMS] \n"

   # bind the public interface to 0.0.0.0 due a issue with mod_cluster advertize (
   #	NOTE: I really don't know why yet, but the multicast advertize on RHEL7 Docker container only works 
   # 	      if I bind the public interface of JBoss EAP node to 0.0.0.0 addr)
   #	      Maybe I'm doing something wrong :-/
   exec $JBOSS_HOME/bin/standalone.sh \
		-c standalone-full.xml \
		-b 0.0.0.0 -bunsecure="0.0.0.0" \
		-bmanagement=0.0.0.0 $ADDITIONAL_PARAMS

elif [ "$EAP_RUNTIME_MODE" == 'domain' ]
then
   echo -e "\n\t >>> starting JBoss EAP $EAP_VERSION in Domain mode <<<"
   echo -e "\t\t using the IP $CONTAINER_IP_ADDR "
   echo -e "\t\t startup parameters passed to conatiner: [$@] "
   
   ADDITIONAL_PARAMS=" "
   [[ "$#" -gt 1  ]] && ADDITIONAL_PARAMS=${@:2}
   
   echo -e "\t\t JBoss startup ADDITIONAL parameters: [$ADDITIONAL_PARAMS] \n "

   #HOST_CONFIG="host.xml"

   #[[ "$#"-lt 3  ]]
   #[[ "${$2}" == "master" ]] && HOST_CONFIG="host-master.xml"
   #[[ "${$2}" == "slave"  ]] && HOST_CONFIG="host-slave.xml"
   #--host-config=<config> 
   #--master-address=<address>

   exec $JBOSS_HOME/bin/domain.sh \
	-b 0.0.0.0 -bunsecure="0.0.0.0" \
	-bmanagement="0.0.0.0" \
	--backup --cached-dc $ADDITIONAL_PARAMS

fi

echo "starting RHQ Agent service..."
$RHQ_AGENT_HOME/bin/rhq-agent-wrapper.sh start

echo "[hit enter key to exit] or run 'docker stop <container>'"
read

echo "stoping RHQ Agent service..."
$RHQ_AGENT_HOME/bin/rhq-agent-wrapper.sh stop

echo "exited $0"

