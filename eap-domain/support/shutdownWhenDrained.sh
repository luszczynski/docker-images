#!/bin/bash

JBOSS_HOME="/opt/jboss/eap/jboss-eap-6.3"

CLI_USER="admin"
CLI_PASSWD="redhat@123"
DOMAIN_CONTROLLER_IP="$(hostname -i)"

echo "Inform The Application Name:"
read appname;

TMP_HOSTS=$($JBOSS_HOME/bin/jboss-cli.sh --user=$CLI_USER --password=$CLI_PASSWD --controller=$DOMAIN_CONTROLLER_IP --connect ":read-children-names(child-type=host)" | grep -Po '".*?"' | grep -v "outcome" | grep -v "success" | grep -v "result" | tr -d '"' | tr -s '\n' ' ')

HOSTS=($TMP_HOSTS)

for host in ${HOSTS[*]}
do

	echo "Looking for servers with $appname deployed at host: $host ...";

	TMP_SERVERS=$($JBOSS_HOME/bin/jboss-cli.sh --user=$CLI_USER --password=$CLI_PASSWD --controller=$DOMAIN_CONTROLLER_IP --connect "/host=$host:read-children-names(child-type=server)" | grep -Po '".*?"' | grep -v "outcome" | grep -v "success" | grep -v "result" | tr -d '"' | tr -s '\n' ' ')
	
	SERVERS=($TMP_SERVERS)
	
	for server in ${SERVERS[*]}
	do
		TMP_APPS=$($JBOSS_HOME/bin/jboss-cli.sh --user=$CLI_USER --password=$CLI_PASSWD --controller=$DOMAIN_CONTROLLER_IP --connect  "/host=$host/server=$server:read-children-names(child-type=deployment)" | grep -Po '".*?"' | grep -v "outcome" | grep -v "success" | grep -v "result" | tr -d '"' | tr -s '\n' ' ')

		APPS=($TMP_APPS)
	
		for app in ${APPS[*]}
		do
            if [ "$appname" == "$app" ]; then
                echo "Found $appname deployed at $server ...";
                echo "Monitoring Active Sessions on $appname at $server ...";
				while [ 1 == 1 ]; do

        				QTD_ACTIVE_SESSION=$($JBOSS_HOME/bin/jboss-cli.sh --user=$CLI_USER --password=$CLI_PASSWD --controller=$DOMAIN_CONTROLLER_IP --connect "/host=$host/server=$server/deployment=$appname/subsystem=web:read-attribute(name=active-sessions)" | grep result | cut -d">" -f2 | tr -d " ")
        				echo "Current Active Sessions on Application: $appname at $server: $QTD_ACTIVE_SESSION"

        				if [ ! -z $QTD_ACTIVE_SESSION ]; then
                				if [ "$QTD_ACTIVE_SESSION"  == "0" ]; then
							echo "Stopping app $app at"
							echo "HOST => $host"
							echo "SERVER => $server"
                        				$JBOSS_HOME/bin/jboss-cli.sh --user=$CLI_USER --password=$CLI_PASSWD --controller=$DOMAIN_CONTROLLER_IP --connect "/host=$host/server-config=$server:stop"
                				fi
        				fi

        				sleep 5;

				done

			fi
		done

	done
	
done
