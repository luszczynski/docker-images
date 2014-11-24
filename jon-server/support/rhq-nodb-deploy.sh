#!/bin/bash
# Credit: https://github.com/shipyard/shipyard-deploy/
# See also: https://github.com/vnugent/rhq-psql-docker
echo "Setup starting ..."
mkdir -p /opt/jboss/jon/
unzip -q -d /opt/jboss/jon $HOME/jon-server-3.3.0.GA.zip
DB_SERVER=jon-postgres
RHQ_HOME=/opt/jboss/jon/jon-server-3.3.0.GA

if [ ! -z $DB_SERVER ];
then
        echo "Configuring RHQ/JON Server to use '$DB_SERVER' database server instead of localhost"
        conn_url="s;^#\?rhq\.server\.database\.connection\-url=jdbc:postgresql.*$;rhq.server.database.connection-url=jdbc:postgresql://${DB_SERVER}:5432/rhq;"
        db_serv="s;^#\?rhq\.server\.database\.server\-name=.*$;rhq.server.database.server-name=${DB_SERVER};g"
        rhq_sync="s;^#\?rhq\.sync\.endpoint\-address=false.*$;rhq.sync.endpoint-address=true;g"
        auto_install="s;^#\?rhq\.autoinstall\.server\.admin\.password=.*$;rhq.autoinstall.server.admin.password=rhqadmin;g"

        hostlocal="s;^#\?rhq\.storage\.hostname=.*$;rhq.storage.hostname=localhost;g"
        seed="s;^#\?rhq\.storage\.seeds=.*$;rhq.storage.seeds=localhost;g"

        sed -i $db_serv ${RHQ_HOME}/bin/rhq-server.properties
        sed -i $conn_url ${RHQ_HOME}/bin/rhq-server.properties
        sed -i $rhq_sync ${RHQ_HOME}/bin/rhq-server.properties
        sed -i $auto_install ${RHQ_HOME}/bin/rhq-server.properties

		sed -i $hostlocal ${RHQ_HOME}/bin/rhq-storage.properties
        sed -i $seed ${RHQ_HOME}/bin/rhq-storage.properties

fi
sed -i 's;^jboss\.bind\.address=;jboss.bind.address=0.0.0.0;g' ${RHQ_HOME}/bin/rhq-server.properties

rm $HOME/jon-server-3.3.0.GA.zip
cp $HOME/*.zip ${RHQ_HOME}/plugins/

${RHQ_HOME}/bin/rhqctl install --server --storage --start

tail -F ${RHQ_HOME}/logs/server.log