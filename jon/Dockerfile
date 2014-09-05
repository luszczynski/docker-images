#######################################################################
#                                                                     #
# Creates a base CentOS image with JON Server and PostgreSQL	      #
#                                                                     #
#######################################################################

# Use the centos base image
FROM luszczynski/centos6:java-version

MAINTAINER gluszczy <gluszczy@redhat.com>

####################
# Install PostgreSQL
####################
USER root
RUN yum --nogpgcheck -y install postgresql-server postgresql-contrib;yum clean all
RUN service postgresql initdb

# PostgreSQL setup
USER postgres
ENV PGDATA /var/lib/pgsql/data
ENV HOME /home/jboss
ENV JAVA_HOME /usr/lib/jvm/jre

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible. 
RUN echo "local all all trust" > $PGDATA/pg_hba.conf
RUN echo "host all all 127.0.0.1/32 trust" >> $PGDATA/pg_hba.conf
RUN echo "host all all ::1/128 trust" >> $PGDATA/pg_hba.conf

RUN echo "" >> $PGDATA/pg_hba.conf
#RUN echo "listen_addresses='*'" >> $PGDATA/postgresql.conf
#RUN echo "## performance changes for JBoss ON" >> $PGDATA/postgresql.conf
#RUN echo "shared_buffers = 80MB #  default is 32MB " >> $PGDATA/postgresql.conf
#RUN echo "work_mem = 2048 #  default is 1MB" >> $PGDATA/postgresql.conf
#RUN echo "checkpoint_segments = 10 #  default is 3" >> $PGDATA/postgresql.conf

USER root
RUN service postgresql start; createuser -h127.0.0.1 -p5432 -Upostgres -s rhqadmin; createdb -h127.0.0.1 -p5432 -Upostgres -O rhqadmin rhq;

############################################
# Install JON
############################################
RUN mkdir /tmp/software; mkdir /tmp/support; mkdir -p /opt/jboss/jon

COPY software/jon-server-3.2.0.GA.zip /tmp/software/
COPY software/jon-plugin-pack-eap-3.2.0.GA.zip /tmp/software/

RUN unzip /tmp/software/jon-server-3.2.0.GA.zip -d /opt/jboss/jon/

RUN unzip /tmp/software/jon-plugin-pack-eap-3.2.0.GA.zip -d /opt/jboss/
RUN cp /opt/jboss/jon-plugin-pack-eap-3.2.0.GA/*.jar /opt/jboss/jon/jon-server-3.2.0.GA/plugins/

COPY support/rhq-server.properties /opt/jboss/jon/jon-server-3.2.0.GA/bin/
COPY support/rhq-storage.properties /opt/jboss/jon/jon-server-3.2.0.GA/bin/

RUN chown -R jboss.jboss /opt/jboss/jon

RUN service postgresql start; /opt/jboss/jon/jon-server-3.2.0.GA/bin/rhqctl install

RUN echo "alias ll='ls -l --color=auto'" >> $HOME/.bash_profile
RUN echo "alias grep='grep --color=auto'" >> $HOME/.bash_profile

# start.sh
USER root
COPY support/start.sh $HOME/start.sh
RUN chmod +x $HOME/start.sh

# Clean up
RUN rm -rf /tmp/software; rm -rf /tmp/support

EXPOSE 22 7080

CMD $HOME/start.sh
