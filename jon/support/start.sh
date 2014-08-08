#!/bin/sh
echo "JON Start script"

service sshd start
service postgresql start

sed -i "s/rhq.communications.connector.bind-address=/rhq.communications.connector.bind-address=$(hostname -i)/g" /opt/jboss/jon/jon-server-3.2.0.GA/bin/rhq-server.properties

/opt/jboss/jon/jon-server-3.2.0.GA/bin/rhqctl start

cat /opt/jboss/jon/jon-server-3.2.0.GA/bin/rhq-server.properties

tail -f /opt/jboss/jon/jon-server-3.2.0.GA/logs/server.log

