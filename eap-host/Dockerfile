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
RUN chown -R jboss.jboss  $HOME $INSTALLDIR_EAP

USER jboss

COPY software/$EAP_ZIP_NAME $SOFTWARE/
COPY software/$EAP_PATCH_NAME $SOFTWARE/

RUN unzip $HOME/software/$EAP_ZIP_NAME -d $INSTALLDIR_EAP/

COPY support/mgmt-groups.properties $EAP_HOME/domain/configuration/mgmt-groups.properties
COPY support/mgmt-users.properties $EAP_HOME/domain/configuration/mgmt-users.properties
COPY support/host-slave.xml $EAP_HOME/domain/configuration/host-slave.xml
COPY support/start.sh $HOME/start.sh 

RUN $EAP_HOME/bin/jboss-cli.sh --user=admin --password=redhat@123 --controller=localhost "patch apply $HOME/software/$EAP_PATCH_NAME"

############################################
# Install JON Agent
############################################
USER root
COPY software/rhq-enterprise-agent-4.12.0.JON330GA.jar $SOFTWARE/
RUN java -jar $HOME/software/rhq-enterprise-agent-4.12.0.JON330GA.jar --install=$INSTALLDIR_JON_AGENT/
COPY support/agent-configuration.xml $INSTALLDIR_JON_AGENT/rhq-agent/conf/

# start.sh
USER root

RUN chown -R jboss.jboss $EAP_HOME

# Clean up
RUN rm -rf $SUPPORT
RUN rm -rf $SOFTWARE

EXPOSE 8080 9990 9999

ENTRYPOINT ["/home/jboss/start.sh"]
