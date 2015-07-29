#!/bin/bash
set -e

CONTAINER_IP_ADDR=$(ip a s | sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}')

# call the runtime setup
#. /runtime_setup.sh

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

   # some properties to avoid JGroups issues when using cluster/ha profiles
   JAVA_OPTS="-Djboss.node.name=$HOSTNAME -Djgroups.bind_addr=$CONTAINER_IP_ADDR"
   # when using mod_cluster, change the default node name
   JAVA_OPTS="$JAVA_OPTS -Djboss.mod_cluster.jvmRoute=$HOSTNAME -DjvmRoute=$HOSTNAME"
   export JAVA_OPTS

   # bind the public interface to 0.0.0.0 due a issue with mod_cluster advertize (
   #	NOTE: I really don't know why yet, but the multicast advertize on RHEL7 Docker container only works 
   # 	      if I bind the public interface of JBoss EAP node to 0.0.0.0 addr)
   #	      Maybe I'm doing something wrong :-/
   exec $JBOSS_HOME/bin/standalone.sh \
		-c standalone-full.xml \
		-bpublic="0.0.0.0" \
		-bunsecure="0.0.0.0" \
		-bmanagement="0.0.0.0" $ADDITIONAL_PARAMS &

   STOP_JBOSS_CMD="$JBOSS_HOME/bin/jboss-cli.sh -c --controller=127.0.0.1:9999 --command=':shutdown()'"

elif [ "$EAP_RUNTIME_MODE" == 'domain' ]
then
   echo -e "\n\t >>> starting JBoss EAP $EAP_VERSION in Domain mode <<<"
   echo -e "\t\t using the IP $CONTAINER_IP_ADDR "
   echo -e "\t\t startup parameters passed to conatiner: [$@] "
   
   ADDITIONAL_PARAMS=" "
   [[ "$#" -gt 1  ]] && ADDITIONAL_PARAMS=${@:2}
   
   echo -e "\t\t JBoss startup ADDITIONAL parameters: [$ADDITIONAL_PARAMS] \n "

   #HOST_CONFIG="host.xml"

   #[[ "${$2}" == "master" ]] && HOST_CONFIG="host-master.xml"
   #[[ "${$2}" == "slave"  ]] && HOST_CONFIG="host-slave.xml"
   #--host-config=<config> 
   #--master-address=<address>

   #define the hostname used in stop commando for domain mode
   JBOSS_HOST_NAME="master"
   # if is a host slave sets it as DC backup
   [[ $@ == *slave* ]] && JBOSS_HOST_NAME="$HOSTNAME" && $ADDITIONAL_PARAMS="$ADDITIONAL_PARAMS --backup" 

   # some properties to avoid JGroups issues when using cluster/ha profiles
   SERVER_OPTS="-Djboss.node.name=$HOSTNAME -Djgroups.bind_addr=$CONTAINER_IP_ADDR"
   export SERVER_OPTS

   exec $JBOSS_HOME/bin/domain.sh \
	-bpublic="0.0.0.0" \
	-bunsecure="0.0.0.0" \
	-bmanagement="0.0.0.0" \
	$ADDITIONAL_PARAMS &

   STOP_JBOSS_CMD="$JBOSS_HOME/bin/jboss-cli.sh --connect --controller=127.0.0.1:9999 command='/host=$JBOSS_HOST_NAME:shutdown'"

fi

echo "starting RHQ Agent service..."
$RHQ_AGENT_HOME/bin/rhq-agent-wrapper.sh start

stop_container(){
        echo -e "\n\t >>> shutdown the container process...\n"
	echo -e "\t\tstoping RHQ Agent service..."
	$RHQ_AGENT_HOME/bin/rhq-agent-wrapper.sh stop
	
	echo -e "\t\tstoping JBoss service..."
	echo -e "\t\t [$STOP_JBOSS_CMD]"
	eval "$STOP_JBOSS_CMD"
        
        echo "exited $0"
}

# catch the stop/kill signals from shell
trap 'echo TRAPed signal; stop_container' HUP INT QUIT KILL TERM

echo -e "\n\t >>> Container's startup process ($0) runing in foreground . HIT enter to STOP!!!"
read

