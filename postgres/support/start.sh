#!/bin/sh

echo "$(hostname -i | cut -d " " -f2) $(hostname)" > /dnsmasq.hosts/0host_$(hostname)
test ! -e $HOME/agent.sh || $HOME/agent.sh
su -l postgres -c "pg_ctl -l server.log -w -D /var/lib/pgsql/data start"
su -l postgres -c "tail -f server.log"