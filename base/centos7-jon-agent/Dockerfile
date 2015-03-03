FROM luszczynski/centos7-java

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

ENV INSTALLDIR_JON_AGENT=/opt/jboss/jon JON_AGENT_HOME=$INSTALLDIR_JON_AGENT/rhq-agent

COPY software/rhq-enterprise-agent-4.12.0.JON330GA.jar $SOFTWARE/
RUN mkdir -p $INSTALLDIR_JON_AGENT && java -jar $HOME/software/rhq-enterprise-agent-4.12.0.JON330GA.jar --install=$INSTALLDIR_JON_AGENT/
COPY support/agent-configuration.xml $JON_AGENT_HOME/conf/

RUN echo 'sed -i "s/agent_name_script/$(hostname)/g" $JON_AGENT_HOME/conf/agent-configuration.xml' >> $HOME/run.sh && \
	echo 'sed -i "s/agent_ip_script/$(hostname)/g" $JON_AGENT_HOME/conf/agent-configuration.xml' >> $HOME/run.sh && \
	echo 'sed -i "s/server_ip_script/jon-server/g" $JON_AGENT_HOME/conf/agent-configuration.xml' >> $HOME/run.sh && \
	echo "$JON_AGENT_HOME/bin/rhq-agent-wrapper.sh start" >> $HOME/run.sh && \
	echo "" >> $HOME/run.sh