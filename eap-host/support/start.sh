#!/bin/sh

echo "JBoss EAP Start script"

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 [Nome do host-controller]" >&2
  exit 1
fi

# SSH
#service sshd start

sed -i "s/agent_name_script/$(hostname -i)/g" $INSTALLDIR_JON_AGENT/rhq-agent/conf/agent-configuration.xml
sed -i "s/agent_ip_script/$(hostname -i)/g" $INSTALLDIR_JON_AGENT/rhq-agent/conf/agent-configuration.xml
sed -i "s/server_ip_script/jon-server/g" $INSTALLDIR_JON_AGENT/rhq-agent/conf/agent-configuration.xml
sed -i 's/name=""/name='\"$1\"'/g' $EAP_HOME/domain/configuration/host-slave.xml
sed -i 's/ip_jgroups/'$(hostname -i)'/g' $EAP_HOME/domain/configuration/host-slave.xml
echo 0 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts
$INSTALLDIR_JON_AGENT/rhq-agent/bin/rhq-agent-wrapper.sh start

# Run jboss
runuser -l jboss -c "$EAP_HOME/bin/domain.sh --host-config=host-slave.xml --master-address=eap-domain -b 0.0.0.0 -bmanagement 0.0.0.0 -bunsecure 0.0.0.0"








