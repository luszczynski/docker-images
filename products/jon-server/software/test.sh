#!/bin/sh

RHQ_SERVER_HOME="~/Downloads/JON/jon-server-3.3.0.GA"
#RHQ_SERVER_HOME="/opt/redhat/jon-server-3.3.0.GA"

# test if the rhq-server is completely installed
if [[ ! -f "$RHQ_SERVER_HOME/logs/rhq-installer.log" ]]  ||
   [[ ! -d "$RHQ_SERVER_HOME/jbossas/standalone/data" ]] ||
   [[ ! -d "$RHQ_SERVER_HOME/jbossas/standalone/tmp" ]];
then
        echo -e "\n\t >>> Install JON Server <<< \n"
        #${RHQ_SERVER_HOME}/bin/rhqctl install &
        #wait %1

        #echo -e "\n\t >>> Apply Patches/Updates to JON Server <<< \n"
        #$SUPPORT/applyPatch.sh &
        #wait %1
fi

