#######################################################################
#                                                                     #
# Creates a base CentOS image with Red Hat JBoss Data Virtualization  #
#                                                                     #
#######################################################################

FROM luszczynski/centos7:jon-agent

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

############################################
# Set environment variables
############################################
ENV JDV_PATCH_NAME dv-6.0_3_2014.zip
ENV JDV_JAR_NAME jboss-dv-installer-6.0.0.GA-redhat-4.jar
ENV INSTALL_DIR_JDV /opt/jboss/jdv
ENV JDV_HOME $INSTALL_DIR_JDV/jboss-eap-6.1/

############################################
# Install JBoss EAP
############################################

RUN mkdir -p $INSTALL_DIR_JDV && \
	chown -R jboss.jboss $HOME $INSTALL_DIR_JDV $SOFTWARE

USER jboss

COPY software/$JDV_JAR_NAME software/$JDV_PATCH_NAME $SOFTWARE/
COPY support/install.xml $SUPPORT/

RUN java -jar $SOFTWARE/$JDV_JAR_NAME $SUPPORT/install.xml && \
	unzip -o $SOFTWARE/$JDV_PATCH_NAME -d $INSTALL_DIR_JDV/
	
COPY support/*.properties $JDV_HOME/standalone/configuration/

USER root

RUN chown -R jboss.jboss $INSTALL_DIR_JDV

# start.sh
RUN echo 'runuser -l jboss -c "$JDV_HOME/bin/standalone.sh -b $MYIP -bmanagement $MYIP -bunsecure $MYIP"' >> $HOME/run.sh

# Clean up
RUN rm -rf $SUPPORT && \
	rm -rf $SOFTWARE

EXPOSE 8080 9990 9999 31000 35432

CMD ["/home/jboss/run.sh"]