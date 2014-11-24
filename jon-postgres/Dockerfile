#######################################################################
#                                                                     #
# Creates a base CentOS image with postgresql-server 				  #
#                                                                     #
#######################################################################

FROM luszczynski/centos6:java-version

MAINTAINER gluszczy <gluszczy@redhat.com>

ENV INSTALLDIR_JON_AGENT /opt/jboss/jon

RUN mkdir -p $SOFTWARE; mkdir -p $SUPPORT; mkdir -p $INSTALLDIR_JON_AGENT;

############################################
# Install JON Agent
############################################
COPY software/rhq-enterprise-agent-4.12.0.JON330GA.jar $SOFTWARE/
RUN java -jar $HOME/software/rhq-enterprise-agent-4.12.0.JON330GA.jar --install=$INSTALLDIR_JON_AGENT/
COPY support/agent-configuration.xml $INSTALLDIR_JON_AGENT/rhq-agent/conf/

# Update the system
RUN yum install -y postgresql-server postgresql-contrib; yum clean all

RUN \
  su -l postgres -c "/usr/bin/initdb -D '/var/lib/pgsql/data' --auth='ident'" >> /var/lib/pgsql/initdb.log 2>&1 < /dev/null;\
  sed -i 's/ident/trust/g'  /var/lib/pgsql/data/pg_hba.conf;\
  su -l postgres -c "pg_ctl -l server.log -w -D /var/lib/pgsql/data start";\
  psql -h 127.0.0.1 -p 5432 -U postgres --command="CREATE USER rhqadmin WITH password 'rhqadmin'";\
  createdb -h 127.0.0.1 -p 5432 -U postgres -O rhqadmin rhq;\
  echo "host all  all    0.0.0.0/0  md5" >> /var/lib/pgsql/data/pg_hba.conf;\  
  echo "listen_addresses='*'" >> /var/lib/pgsql/data/postgresql.conf;\
  su -l postgres -c "pg_ctl -l server.log -w -D /var/lib/pgsql/data stop"

#RUN echo "## performance changes for JBoss ON" >> $PGDATA/postgresql.conf
#RUN echo "shared_buffers = 80MB #  default is 32MB " >> $PGDATA/postgresql.conf
#RUN echo "work_mem = 2048 #  default is 1MB" >> $PGDATA/postgresql.conf
#RUN echo "checkpoint_segments = 10 #  default is 3" >> $PGDATA/postgresql.conf

USER root
RUN echo "#!/bin/sh" >> $HOME/run.sh && \
	echo "echo JBoss Postgres Start script" >> $HOME/run.sh && \
	echo 'sed -i "s/agent_name_script/$(hostname -i)/g" $INSTALLDIR_JON_AGENT/rhq-agent/conf/agent-configuration.xml' >> $HOME/run.sh && \
	echo 'sed -i "s/agent_ip_script/$(hostname -i)/g" $INSTALLDIR_JON_AGENT/rhq-agent/conf/agent-configuration.xml' >> $HOME/run.sh && \
	echo 'sed -i "s/server_ip_script/jon-server/g" $INSTALLDIR_JON_AGENT/rhq-agent/conf/agent-configuration.xml' >> $HOME/run.sh && \
	echo "echo 0 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts" >> $HOME/run.sh && \
	echo "$INSTALLDIR_JON_AGENT/rhq-agent/bin/rhq-agent-wrapper.sh start" >> $HOME/run.sh && \
	echo "su -l postgres -c 'pg_ctl -l server.log -w -D /var/lib/pgsql/data start; tail -F server.log'" >> $HOME/run.sh && \
	chmod +x $HOME/run.sh

EXPOSE 5432

CMD /home/jboss/run.sh