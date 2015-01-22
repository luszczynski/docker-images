FROM luszczynski/centos7-jon-agent

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

############################################
# Set environment variables
############################################
ENV JDG_ZIP_NAME jboss-datagrid-6.3.2-server.zip
ENV INSTALLDIR_JDG /opt/jboss/jdg
ENV JDG_HOME $INSTALLDIR_JDG/jboss-datagrid-6.3.2-server

############################################
# Install JBoss JDG
############################################

RUN mkdir -p $INSTALLDIR_JDG && \
	chown -R jboss.jboss $INSTALLDIR_JDG

USER jboss

COPY software/$JDG_ZIP_NAME $SOFTWARE/

RUN unzip $HOME/software/$JDG_ZIP_NAME -d $INSTALLDIR_JDG/

COPY support/*.properties $JDG_HOME/standalone/configuration/
COPY support/clustered.xml $JDG_HOME/standalone/configuration/
COPY support/clustered.conf $JDG_HOME/bin/

# start.sh
USER root

RUN echo 'if [ "$#" -ne 1 ]; then' >> $HOME/run.sh && \
	echo 'echo "Usage: $0 [JDG instance name]" >&2' >> $HOME/run.sh && \
	echo 'exit 1' >> $HOME/run.sh && \
	echo 'fi' >> $HOME/run.sh && \
	echo 'runuser -l jboss -c "$JDG_HOME/bin/clustered.sh -b $MYIP -bmanagement $MYIP -Djboss.node.name=$1"' >> $HOME/run.sh

RUN chown -R jboss. $JDG_HOME

# Clean up
RUN rm -rf $SUPPORT && rm -rf $SOFTWARE

EXPOSE 8080 9990 11222 11211

ENTRYPOINT ["/home/jboss/run.sh"]
