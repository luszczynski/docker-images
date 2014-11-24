#######################################################################
#                                                                     #
# Creates a base Fedora image with EAP standalone 					  #
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

############################################
# Install JON Agent
############################################
USER root
COPY software/rhq-enterprise-agent-4.12.0.JON330GA.jar $HOME/software/
RUN java -jar $HOME/software/rhq-enterprise-agent-4.12.0.JON330GA.jar --install=$INSTALLDIR_JON_AGENT/
COPY support/agent-configuration.xml $INSTALLDIR_JON_AGENT/rhq-agent/conf/

COPY support/start.sh $HOME/
RUN chmod +x $HOME/start.sh

# Clean up
RUN rm -rf $SUPPORT
RUN rm -rf $SOFTWARE

EXPOSE 8080 9990 9999

ENTRYPOINT ["/home/jboss/start.sh"]
