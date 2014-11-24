#######################################################################
#                                                                     #
# Creates a base Fedora image with JBoss Data Virtualization 6.0.0.GA #
#                                                                     #
#######################################################################

# Use the centos base image
FROM luszczynski/centos6:java-version

MAINTAINER gluszczy <gluszczy@redhat.com>

ENV INSTALLDIR_JON_AGENT /opt/jboss/jon
ENV INSTALLDIR_BPMS /opt/jboss/bpms

RUN mkdir -p $SOFTWARE; mkdir -p $SUPPORT; mkdir -p $INSTALLDIR_JON_AGENT; mkdir -p $INSTALLDIR_BPMS;

COPY software/jboss-eap-6.1.1.zip $SOFTWARE/
COPY software/jboss-bpms-6.0.3.GA-redhat-1-deployable-eap6.x.zip $SOFTWARE/
COPY support/install.xml $SUPPORT/
RUN unzip $SOFTWARE/jboss-eap-6.1.1.zip -d $INSTALLDIR_BPMS/
RUN unzip -o $SOFTWARE/jboss-bpms-6.0.3.GA-redhat-1-deployable-eap6.x.zip -d $INSTALLDIR_BPMS

COPY support/mgmt-users.properties $INSTALLDIR_BPMS/jboss-eap-6.1/standalone/configuration/
COPY support/application-users.properties $INSTALLDIR_BPMS/jboss-eap-6.1/standalone/configuration/
COPY support/application-roles.properties $INSTALLDIR_BPMS/jboss-eap-6.1/standalone/configuration/

############################################
# Install JON Agent
############################################
COPY software/rhq-enterprise-agent-4.12.0.JON330GA.jar $SOFTWARE/
RUN java -jar $HOME/software/rhq-enterprise-agent-4.12.0.JON330GA.jar --install=$INSTALLDIR_JON_AGENT/
COPY support/agent-configuration.xml $INSTALLDIR_JON_AGENT/rhq-agent/conf/

#RUN rm -rf $INSTALLDIR/jboss-eap-6.1/standalone/configuration/standalone_xml_history/current

RUN chown -R jboss: $INSTALLDIR_BPMS/

# start.sh
USER root
RUN echo "#!/bin/sh" >> $HOME/run.sh
RUN echo "echo JBoss BPMS Start script" >> $HOME/run.sh
RUN echo 'sed -i "s/agent_name_script/$(hostname -i)/g" $INSTALLDIR_JON_AGENT/rhq-agent/conf/agent-configuration.xml' >> $HOME/run.sh
RUN echo 'sed -i "s/agent_ip_script/$(hostname -i)/g" $INSTALLDIR_JON_AGENT/rhq-agent/conf/agent-configuration.xml' >> $HOME/run.sh
RUN echo 'sed -i "s/server_ip_script/jon-server/g" $INSTALLDIR_JON_AGENT/rhq-agent/conf/agent-configuration.xml' >> $HOME/run.sh 
RUN echo "echo 0 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts" >> $HOME/run.sh
RUN echo "$INSTALLDIR_JON_AGENT/rhq-agent/bin/rhq-agent-wrapper.sh start" >> $HOME/run.sh
RUN echo "runuser -l jboss -c '$INSTALLDIR_BPMS/jboss-eap-6.1/bin/standalone.sh -c standalone.xml -b 0.0.0.0 -bmanagement 0.0.0.0'" >> $HOME/run.sh
RUN chmod +x $HOME/run.sh

# Clean up
RUN rm -rf $SUPPORT
RUN rm -rf $SOFTWARE

EXPOSE 8080 9990

CMD /home/jboss/run.sh
