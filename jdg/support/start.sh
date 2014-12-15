#!/bin/sh

echo "JBoss JDG Start script"

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 [JDG instance name]" >&2
  exit 1
fi

echo "$(hostname -i | cut -d " " -f2) $(hostname)" > /dnsmasq.hosts/0host_$(hostname)
test ! -e $HOME/agent.sh || $HOME/agent.sh

# Run jboss
runuser -l jboss -c "$JDG_HOME/bin/clustered.sh -b $(hostname -i) -bmanagement $(hostname -i) -Djboss.node.name=$1"








