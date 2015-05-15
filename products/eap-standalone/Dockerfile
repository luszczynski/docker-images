FROM luszczynski/centos7-jon-agent

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

############################################
# Set environment variables
############################################
#ENV EAP_PATCH_NAME jboss-eap-6.3.2-patch.zip
ENV EAP_ZIP_NAME jboss-eap-6.4.0.zip
ENV INSTALLDIR_EAP /opt/jboss/eap
ENV EAP_HOME $INSTALLDIR_EAP/jboss-eap-6.4
ENV JON_MODULE_ZIP1_NAME rhq-rtfilter-module.zip
ENV JON_MODULE_ZIP2_NAME rhq-rtfilter-subsystem-module.zip

RUN mkdir -p $INSTALLDIR_EAP && \
	chown -R jboss.jboss  $HOME $INSTALLDIR_EAP

USER jboss

COPY software/* $HOME/software/

RUN unzip $HOME/software/$EAP_ZIP_NAME -d $INSTALLDIR_EAP; \
       unzip $HOME/software/$JON_MODULE_ZIP1_NAME -d $INSTALLDIR_EAP/jboss-eap-6.4/modules/; \ 
       unzip $HOME/software/$JON_MODULE_ZIP2_NAME -d $INSTALLDIR_EAP/jboss-eap-6.4/modules/ 

COPY support/*.properties $INSTALLDIR_EAP/jboss-eap-6.4/standalone/configuration/
COPY support/*.xml $INSTALLDIR_EAP/jboss-eap-6.4/standalone/configuration/

#RUN $INSTALLDIR_EAP/jboss-eap-6.3/bin/jboss-cli.sh --user=admin --password=redhat@123 --controller=localhost "patch apply $HOME/software/$EAP_PATCH_NAME"

USER root
RUN echo 'runuser -l jboss -c "exec $EAP_HOME/bin/standalone.sh -c standalone-full-ha.xml -b 0.0.0.0 -bmanagement $MYIP -bunsecure $MYIP $@"' >> $HOME/run.sh

# Clean up
RUN rm -rf $SUPPORT && rm -rf $SOFTWARE

EXPOSE 8080 9990 9999

ENTRYPOINT ["/home/jboss/run.sh"]
