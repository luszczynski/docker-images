#!/bin/bash

JBOSS_HOME="jboss-eap-6.3"

CLI_USER="admin"
CLI_PASSWD="redhat@123"
DOMAIN_CONTROLLER_IP=$(hostname -i)
APACHE_IP="apache"

# Get All Hosts
function getAllHosts(){
	TMP_HOSTS=$($JBOSS_HOME/bin/jboss-cli.sh --user=$CLI_USER --password=$CLI_PASSWD --controller=$DOMAIN_CONTROLLER_IP --connect ":read-children-names(child-type=host)" | grep -Po '".*?"' | grep -v "outcome" | grep -v "success" | grep -v "result" | tr -d '"' | tr -s '\n' ' ')

	HOSTS=($TMP_HOSTS)
}

# Get all hosts servers
function getAllServers(){
	TMP_SERVERS=$($JBOSS_HOME/bin/jboss-cli.sh --user=$CLI_USER --password=$CLI_PASSWD --controller=$DOMAIN_CONTROLLER_IP --connect "/host=$1:read-children-names(child-type=server)" | grep -Po '".*?"' | grep -v "outcome" | grep -v "success" | grep -v "result" | tr -d '"' | tr -s '\n' ' ')
	
	SERVERS=($TMP_SERVERS)
}

# Get all servers apps
function getAllApps(){
	TMP_APPS=$($JBOSS_HOME/bin/jboss-cli.sh --user=$CLI_USER --password=$CLI_PASSWD --controller=$DOMAIN_CONTROLLER_IP --connect  "/host=$1/server=$2:read-children-names(child-type=deployment)" | grep -Po '".*?"' | grep -v "outcome" | grep -v "success" | grep -v "result" | tr -d '"' | tr -s '\n' ' ')

	APPS=($TMP_APPS)
}

# Get ServerGroup from App
# Parameters
# $1 = host
# $2 = server 
function getServerGroupFromApp(){
	SERVER_GROUP_FROM_APP=$($JBOSS_HOME/bin/jboss-cli.sh --user=$CLI_USER --password=$CLI_PASSWD --controller=$DOMAIN_CONTROLLER_IP --connect  "/host=$1/server-config=$2:read-attribute(name=group)" | grep -Po '".*?"' | grep -v "outcome" | grep -v "success" | grep -v "result" | tr -d '"' | tr -s '\n' ' ')
}

# Copy server group with another name
# Parameters:
# $1 = old server group name
# $2 = new server group name
function copyServerGroup(){
	TMP_PROFILE=$($JBOSS_HOME/bin/jboss-cli.sh --user=$CLI_USER --password=$CLI_PASSWD --controller=$DOMAIN_CONTROLLER_IP --connect  "/server-group=$1:read-attribute(name=profile)" | grep -Po '".*?"' | grep -v "outcome" | grep -v "success" | grep -v "result" | tr -d '"' | tr -s '\n' ' ')
	
	TMP_SOCKET_BIND_GROUP=$($JBOSS_HOME/bin/jboss-cli.sh --user=$CLI_USER --password=$CLI_PASSWD --controller=$DOMAIN_CONTROLLER_IP --connect  "/server-group=$1:read-attribute(name=socket-binding-group)" | grep -Po '".*?"' | grep -v "outcome" | grep -v "success" | grep -v "result" | tr -d '"' | tr -s '\n' ' ')
	
	$JBOSS_HOME/bin/jboss-cli.sh --user=$CLI_USER --password=$CLI_PASSWD --controller=$DOMAIN_CONTROLLER_IP --connect  "/server-group=$2:add(profile=$TMP_PROFILE,socket-binding-group=$TMP_SOCKET_BIND_GROUP)" > /dev/null 2>&1
}

# Copy server
# Parameters
# $1 = host
# $2 = Old Server Name
# $3 = New Server Name
# $4 = server group
function copyServer() {
	TMP_SERVER_OFFSET=$($JBOSS_HOME/bin/jboss-cli.sh --user=$CLI_USER --password=$CLI_PASSWD --controller=$DOMAIN_CONTROLLER_IP --connect  "/host=$1/server-config=$2:read-attribute(name=socket-binding-port-offset)" | grep -P '".*?"' | grep -v "outcome" | grep -v "success" | tr -d '"' | tr -s '\n' ' ' | cut -d">" -f2 | tr -d ' ')
	
	TMP_SERVER_SOCKET_BINDING=$($JBOSS_HOME/bin/jboss-cli.sh --user=$CLI_USER --password=$CLI_PASSWD --controller=$DOMAIN_CONTROLLER_IP --connect  "/host=$1/server-config=$2:read-attribute(name=socket-binding-group)" | grep -P '".*?"' | grep -v "outcome" | grep -v "success" | tr -d '"' | tr -s '\n' ' ' | cut -d">" -f2 | tr -d ' ')
	
	$JBOSS_HOME/bin/jboss-cli.sh --user=$CLI_USER --password=$CLI_PASSWD --controller=$DOMAIN_CONTROLLER_IP --connect  "/host=$1/server-config=$3:add(group=$4,auto-start=false,socket-binding-group=$TMP_SERVER_SOCKET_BINDING,socket-binding-port-offset=$[TMP_SERVER_OFFSET+100])" > /dev/null 2>&1

}

# Deploy app
# Parameters
# $1 = path app
# $2 = app deploy name 
# $3 = app deploy runtime name
# $4 = server group
function deploy(){
	$JBOSS_HOME/bin/jboss-cli.sh --user=$CLI_USER --password=$CLI_PASSWD --controller=$DOMAIN_CONTROLLER_IP --connect  "deploy $1 --name=$2 --runtime-name=$3 --server-groups=$4" > /dev/null 2>&1
}

# Start server
# Parameters
# $1 = host
# $2 = server
function startServer(){
	$JBOSS_HOME/bin/jboss-cli.sh --user=$CLI_USER --password=$CLI_PASSWD --controller=$DOMAIN_CONTROLLER_IP --connect  "/host=$1/server-config=$2:start" > /dev/null 2>&1
}

function checkSession(){

	QTD_ACTIVE_SESSION=1;

	while [ $QTD_ACTIVE_SESSION -ge 1 ]; do

        	QTD_ACTIVE_SESSION=$($JBOSS_HOME/bin/jboss-cli.sh --user=$CLI_USER --password=$CLI_PASSWD --controller=$DOMAIN_CONTROLLER_IP --connect "/host=$1/server=$2/deployment=$3/subsystem=web:read-attribute(name=active-sessions)" | grep result | cut -d">" -f2 | tr -d " ")
        	echo "Current Active Sessions on Application: $appname at $server: $QTD_ACTIVE_SESSION"

        	if [ ! -z $QTD_ACTIVE_SESSION ]; then
                	if [ "$QTD_ACTIVE_SESSION"  == "0" ]; then
				echo "Stopping app $4 at"
				echo "HOST => $1"
				echo "SERVER => $2"
                		$JBOSS_HOME/bin/jboss-cli.sh --user=$CLI_USER --password=$CLI_PASSWD --controller=$DOMAIN_CONTROLLER_IP --connect "/host=$1/server-config=$2:stop"
                	fi
        	fi

		sleep 5;

	done
}

echo "Inform The Application Name:"
read appname;

echo "Inform the NEW Application Path:"
read newappname;

getAllHosts

for host in ${HOSTS[*]}
do

	echo "Looking for servers with $appname deployed at host: $host ...";

	getAllServers $host
	
	for server in ${SERVERS[*]}
	do
		getAllApps $host $server
	
		for app in ${APPS[*]}
		do
            		if [ "$appname" == "$app" ]; then
				
				echo "Found $appname deployed at $server ...";
				
				getServerGroupFromApp $host $server
				NEW="_v2"
				NEW_SERVER_GROUP_NAME=`echo "$SERVER_GROUP_FROM_APP$NEW" | tr -d " "`

				echo "Copying server group $SERVER_GROUP_FROM_APP with new name $NEW_SERVER_GROUP_NAME"
				copyServerGroup $SERVER_GROUP_FROM_APP $NEW_SERVER_GROUP_NAME
				
				echo "Copying server $server with new name $server$NEW"
				copyServer $host $server "$server$NEW" $NEW_SERVER_GROUP_NAME
				
				echo "Starting new server $server$NEW"
				startServer $host "$server$NEW"

				echo "Deploying $newappname into $NEW_SERVER_GROUP_NAME"
				deploy $newappname $newappname $appname $NEW_SERVER_GROUP_NAME
				
				COMANDO_DISABLE=`curl -s -X GET http://$APACHE_IP/mod_cluster_manager | grep "$server&" | grep Status | grep Disable | grep -Po 'href="\K[^"]*'` > /dev/null 2>&1
				
				echo "Disabling $appname in $SERVER_GROUP_FROM_APP"
				curl -s -X GET http://$APACHE_IP$COMANDO_DISABLE > /dev/null 2>&1
                		
                		echo "Monitoring Active Sessions on $appname at $server ...";
				checkSession $host $server $appname $app

			fi
		done

	done
	
done
