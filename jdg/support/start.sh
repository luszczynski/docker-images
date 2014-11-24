#!/bin/sh

echo "JBoss JDG Start script"

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 [JDG instance name]" >&2
  exit 1
fi

# SSH
#service sshd start

sed -i "s/agent_name_script/$(hostname -i)/g" $INSTALLDIR_JON_AGENT/rhq-agent/conf/agent-configuration.xml
sed -i "s/agent_ip_script/$(hostname -i)/g" $INSTALLDIR_JON_AGENT/rhq-agent/conf/agent-configuration.xml
sed -i "s/server_ip_script/jon-server/g" $INSTALLDIR_JON_AGENT/rhq-agent/conf/agent-configuration.xml
echo 0 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts
$INSTALLDIR_JON_AGENT/rhq-agent/bin/rhq-agent-wrapper.sh start

# Run jboss
runuser -l jboss -c "$JDG_HOME/bin/clustered.sh -b $(hostname -i) -bmanagement $(hostname -i) -Djboss.node.name=$1"








