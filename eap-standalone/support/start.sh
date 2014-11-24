#!/bin/sh

echo "JBoss EAP Start script"

sed -i "s/agent_name_script/$(hostname -i)/g" $INSTALLDIR_JON_AGENT/rhq-agent/conf/agent-configuration.xml
sed -i "s/agent_ip_script/$(hostname -i)/g" $INSTALLDIR_JON_AGENT/rhq-agent/conf/agent-configuration.xml
sed -i "s/server_ip_script/jon-server/g" $INSTALLDIR_JON_AGENT/rhq-agent/conf/agent-configuration.xml
echo 0 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts
$INSTALLDIR_JON_AGENT/rhq-agent/bin/rhq-agent-wrapper.sh start

runuser -l jboss -c "$EAP_HOME/bin/standalone.sh -b $(hostname -i) -bmanagement $(hostname -i) -bunsecure $(hostname -i) $1"