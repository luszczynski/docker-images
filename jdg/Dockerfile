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
#ENV EAP_PATCH_NAME jboss-eap-6.3.1-patch.zip
ENV JDG_ZIP_NAME jboss-datagrid-6.3.1-server.zip
ENV INSTALLDIR_JDG /opt/jboss/jdg
ENV INSTALLDIR_JON_AGENT /opt/jboss/jon
ENV JDG_HOME $INSTALLDIR_JDG/jboss-datagrid-6.3.1-server
ENV JAVA_HOME /usr/lib/jvm/jre
ENV HOME /home/jboss
ENV SUPPORT $HOME/support
ENV SOFTWARE $HOME/software

############################################
# Install JBoss JDG
############################################

RUN mkdir -p $INSTALLDIR_JON_AGENT; mkdir -p $INSTALLDIR_JDG; mkdir $HOME/support; mkdir $HOME/software
RUN chown -R jboss.jboss  $HOME $INSTALLDIR_JDG

USER jboss

COPY software/$JDG_ZIP_NAME $SOFTWARE/
#COPY software/$EAP_PATCH_NAME $SOFTWARE/

RUN unzip $HOME/software/$JDG_ZIP_NAME -d $INSTALLDIR_JDG/

COPY support/mgmt-groups.properties $JDG_HOME/standalone/configuration/
COPY support/mgmt-users.properties $JDG_HOME/standalone/configuration/
COPY support/clustered.xml $JDG_HOME/standalone/configuration/
COPY support/clustered.conf $JDG_HOME/bin/
COPY support/application-roles.properties $JDG_HOME/standalone/configuration/
COPY support/application-users.properties $JDG_HOME/standalone/configuration/
COPY support/start.sh $HOME/start.sh 

#RUN $JDG_HOME/bin/jboss-cli.sh --user=admin --password=redhat@123 --controller=localhost "patch apply $HOME/software/$EAP_PATCH_NAME"

############################################
# Install JON Agent
############################################
USER root
COPY software/rhq-enterprise-agent-4.12.0.JON330GA.jar $SOFTWARE/
RUN java -jar $HOME/software/rhq-enterprise-agent-4.12.0.JON330GA.jar --install=$INSTALLDIR_JON_AGENT/
COPY support/agent-configuration.xml $INSTALLDIR_JON_AGENT/rhq-agent/conf/

# start.sh
USER root

RUN chown -R jboss.jboss $JDG_HOME

# Clean up
RUN rm -rf $SUPPORT
RUN rm -rf $SOFTWARE

EXPOSE 8080 9990 11222 11211

ENTRYPOINT ["/home/jboss/start.sh"]
