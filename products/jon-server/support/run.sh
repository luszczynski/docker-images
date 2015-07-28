#!/bin/sh

DB_SERVER=jon-postgres
DB_PORT=5432
RHQ_SERVER_HOME=$SOFTWARE_INSTALL_DIR/jon-server-$JON_VERSION

# call the runtime setup
. /runtime_setup.sh

# USE the trap if you need to also do manual cleanup after the service is stopped,
#     or need to start multiple services in the one container
trap "echo TRAPed signal" HUP INT QUIT KILL TERM

# test if the rhq-server is completely installed
if [[ ! -f "$RHQ_SERVER_HOME/logs/rhq-installer.log"  ]] ||
   [[ ! -d "$RHQ_SERVER_HOME/jbossas/standalone/data" ]] ||
   [[ ! -d "$RHQ_SERVER_HOME/jbossas/standalone/tmp"  ]];
then

	#test if the data base backend is up!
	DB_STATUS=`(echo > /dev/tcp/$DB_SERVER/$DB_PORT) >/dev/null 2>&1 && echo "UP" || echo "DOWN"`

	if [ ! -z "$DB_STATUS" -a "$DB_STATUS" == "UP"  ]
	then
		echo -e "\n\t >>> Install RHQ/JON Server <<< \n"
		${RHQ_SERVER_HOME}/bin/rhqctl install &
		wait %1

		echo -e "\n\t >>> Apply Patches/Updates to RHQ/JON Server <<< \n"
		/applyPatch.sh &
		wait %1
	else
		echo -e "\n\t *** There is no Data Base running/listening on $DB_SERVER:$DB_PORT *** \n
		echo -e "\t\t ---> ABORTING INSTALLATION!!! "
		exit 1
	fi
fi

echo -e "\n\t >>> Start RHQ/JON Services (server, storage and agent)... <<< \n"
${RHQ_SERVER_HOME}/bin/rhqctl start

echo "[hit enter key to exit] or run 'docker stop <container>'"
read

# stop service and clean up here
echo "stopping RHQ/JON Services"
${RHQ_SERVER_HOME}/bin/rhqctl stop

echo "exited $0"
