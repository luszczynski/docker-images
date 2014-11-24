#######################################################################
#                                                                     #
# Creates a base CentOS image with Red Hat JBoss Enterprise Platform  #
#                                                                     #
#######################################################################

# Use the centos base image
FROM luszczynski/centos6:java-version

MAINTAINER gluszczy <gluszczy@redhat.com>

############################################
# Set environment variables
############################################
ENV EAP_PATCH_NAME jboss-eap-6.3.2-patch.zip
ENV EAP_ZIP_NAME jboss-eap-6.3.0.zip
ENV INSTALLDIR_EAP /opt/jboss/eap
ENV INSTALLDIR_JON_AGENT /opt/jboss/jon
ENV EAP_HOME $INSTALLDIR_EAP/jboss-eap-6.3
ENV JAVA_HOME /usr/lib/jvm/jre
ENV HOME /home/jboss
ENV SUPPORT $HOME/support
ENV SOFTWARE $HOME/software

############################################
# Install JBoss EAP
############################################

RUN mkdir -p $INSTALLDIR_JON_AGENT; mkdir -p $INSTALLDIR_EAP; mkdir $HOME/support; mkdir $HOME/software
RUN chown -R jboss.jboss  $HOME $INSTALLDIR_EAP $SOFTWARE

USER jboss

COPY software/$EAP_ZIP_NAME $SOFTWARE/
COPY software/$EAP_PATCH_NAME $SOFTWARE/

COPY support/shutdownWhenDrained.sh $HOME/
COPY support/shutdownWhenDrained_v3.0.sh $HOME/
COPY support/contador2.war $HOME/

RUN unzip $HOME/software/$EAP_ZIP_NAME -d $INSTALLDIR_EAP/

COPY support/mgmt-groups.properties $EAP_HOME/domain/configuration/
COPY support/mgmt-users.properties $EAP_HOME/domain/configuration/
COPY support/domain.xml $EAP_HOME/domain/configuration/
COPY support/host-master.xml $EAP_HOME/domain/configuration/

RUN $EAP_HOME/bin/jboss-cli.sh --user=admin --password=redhat@123 --controller=localhost "patch apply $SOFTWARE/$EAP_PATCH_NAME"

############################################
# Install JON Agent
############################################
USER root
COPY software/rhq-enterprise-agent-4.12.0.JON330GA.jar $SOFTWARE/
RUN java -jar $HOME/software/rhq-enterprise-agent-4.12.0.JON330GA.jar --install=$INSTALLDIR_JON_AGENT/
COPY support/agent-configuration.xml $INSTALLDIR_JON_AGENT/rhq-agent/conf/

# start.sh
USER root
RUN echo "#!/bin/sh" >> $HOME/run.sh
RUN echo "echo JBoss EAP Start script" >> $HOME/run.sh
#RUN echo "service sshd start" >> $HOME/run.sh
RUN echo 'sed -i "s/agent_name_script/$(hostname -i)/g" $INSTALLDIR_JON_AGENT/rhq-agent/conf/agent-configuration.xml' >> $HOME/run.sh
RUN echo 'sed -i "s/agent_ip_script/$(hostname -i)/g" $INSTALLDIR_JON_AGENT/rhq-agent/conf/agent-configuration.xml' >> $HOME/run.sh
RUN echo 'sed -i "s/server_ip_script/jon-server/g" $INSTALLDIR_JON_AGENT/rhq-agent/conf/agent-configuration.xml' >> $HOME/run.sh 
RUN echo "echo 0 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts" >> $HOME/run.sh
RUN echo "$INSTALLDIR_JON_AGENT/rhq-agent/bin/rhq-agent-wrapper.sh start" >> $HOME/run.sh
RUN echo 'runuser -l jboss -c "$EAP_HOME/bin/domain.sh -b $(hostname -i) -bmanagement $(hostname -i) -bunsecure $(hostname -i) --host-config=host-master.xml"' >> $HOME/run.sh
RUN chmod +x $HOME/run.sh

# Clean up
RUN rm -rf $SUPPORT
RUN rm -rf $SOFTWARE

EXPOSE 8080 9990 9999

CMD /home/jboss/run.sh

# Finished
