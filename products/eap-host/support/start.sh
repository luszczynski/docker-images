#!/bin/sh

echo "JBoss EAP Start script"

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 [Nome do host-controller]" >&2
  exit 1
fi

echo "$(hostname -i | cut -d " " -f2) $(hostname)" > /dnsmasq.hosts/0host_$(hostname)
test ! -e $HOME/agent.sh || $HOME/agent.sh
sed -i 's/name=""/name='\"$1\"'/g' $EAP_HOME/domain/configuration/host-slave.xml
sed -i 's/ip_jgroups/'$(hostname -i | cut -d " " -f2)'/g' $EAP_HOME/domain/configuration/host-slave.xml

# Run jboss
runuser -l jboss -c "$EAP_HOME/bin/domain.sh --host-config=host-slave.xml --master-address=eap-domain -b 0.0.0.0 -bmanagement 0.0.0.0 -bunsecure 0.0.0.0"








