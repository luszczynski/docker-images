#######################################################################
#                                                                     #
# Creates a base Fedora image with JBoss Data Virtualization 6.0.0.GA #
#                                                                     #
#######################################################################

# Use the centos base image
FROM luszczynski/centos6:java-version

MAINTAINER gluszczy <gluszczy@redhat.com>

############################################
# Set environment variables
############################################
ENV EAP_PATCH_NAME jboss-eap-6.3.1-patch.zip
ENV EAP_ZIP_NAME jboss-eap-6.3.0.zip
ENV INSTALLDIR_EAP /opt/jboss/eap
ENV INSTALLDIR_JON_AGENT /opt/jboss/jon
ENV EAP_HOME $INSTALLDIR_EAP/jboss-eap-6.3
ENV JAVA_HOME /usr/lib/jvm/jre
ENV HOME /home/jboss
ENV SUPPORT $HOME/support
ENV SOFTWARE $HOME/software

RUN mkdir -p $INSTALLDIR_JON_AGENT; mkdir -p $INSTALLDIR_EAP; mkdir $HOME/support; mkdir $HOME/software
RUN chown -R jboss.jboss  $HOME $INSTALLDIR_EAP

USER jboss

COPY software/$EAP_ZIP_NAME $HOME/software/
COPY software/$EAP_PATCH_NAME $HOME/software/

COPY support/mgmt-groups.properties $HOME/support/
COPY support/mgmt-users.properties $HOME/support/

RUN unzip $HOME/software/$EAP_ZIP_NAME -d $INSTALLDIR_EAP

RUN cp $HOME/support/mgmt-groups.properties $INSTALLDIR_EAP/jboss-eap-6.3/standalone/configuration/
RUN cp $HOME/support/mgmt-users.properties $INSTALLDIR_EAP/jboss-eap-6.3/standalone/configuration/

RUN $INSTALLDIR_EAP/jboss-eap-6.3/bin/jboss-cli.sh --user=admin --password=redhat@123 --controller=localhost "patch apply $HOME/software/$EAP_PATCH_NAME"

RUN echo "export JAVA_HOME=/usr/lib/jvm/jre" >> $HOME/.bash_profile
RUN echo "alias ll='ls -l --color=auto'" >> $HOME/.bash_profile
RUN echo "alias grep='grep --color=auto'" >> $HOME/.bash_profile

############################################
# Install JON Agent
############################################
USER root
COPY software/rhq-enterprise-agent-4.9.0.JON320GA.jar $HOME/software/
RUN java -jar $HOME/software/rhq-enterprise-agent-4.9.0.JON320GA.jar --install=$INSTALLDIR_JON_AGENT/
COPY support/agent-configuration.xml $INSTALLDIR_JON_AGENT/rhq-agent/conf/

# start.sh
USER root
RUN echo "#!/bin/sh" >> $HOME/run.sh
RUN echo "echo JBoss EAP Start script" >> $HOME/run.sh
RUN echo 'if [ "$#" -ne 1 ]; then' >> $HOME/run.sh
RUN echo '  echo "Usage: $0 [standalone.xml | standalone-full.xml | standalone-ha.xml | standalone-full-ha.xml]"' >> $HOME/run.sh
RUN echo "  exit 1" >> $HOME/run.sh
RUN echo "fi" >> $HOME/run.sh
RUN echo "service sshd start" >> $HOME/run.sh
RUN echo 'sed -i "s/agent_name_script/$(hostname -i)/g" $INSTALLDIR_JON_AGENT/rhq-agent/conf/agent-configuration.xml' >> $HOME/run.sh
RUN echo 'sed -i "s/agent_ip_script/$(hostname -i)/g" $INSTALLDIR_JON_AGENT/rhq-agent/conf/agent-configuration.xml' >> $HOME/run.sh
RUN echo 'sed -i "s/server_ip_script/jon-server/g" $INSTALLDIR_JON_AGENT/rhq-agent/conf/agent-configuration.xml' >> $HOME/run.sh 
RUN echo "echo 0 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts" >> $HOME/run.sh
RUN echo "$INSTALLDIR_JON_AGENT/rhq-agent/bin/rhq-agent-wrapper.sh start" >> $HOME/run.sh
RUN echo 'runuser -l jboss -c "$EAP_HOME/bin/standalone.sh -b $(hostname -i) -bmanagement $(hostname -i) -bunsecure $(hostname -i) -c $1"' >> $HOME/run.sh
RUN chmod +x $HOME/run.sh

# Clean up
RUN rm -rf $SUPPORT
RUN rm -rf $SOFTWARE

EXPOSE 22 8080 9990 9999

ENTRYPOINT ["/home/jboss/run.sh"]
