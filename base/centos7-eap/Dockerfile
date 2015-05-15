FROM luszczynski/centos7-jon-agent

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

ENV EAP_ZIP_NAME jboss-eap-6.4.0.zip
ENV INSTALLDIR_EAP /opt/jboss/eap
ENV EAP_HOME $INSTALLDIR_EAP/jboss-eap-6.4
ENV JON_MODULE_ZIP1_NAME rhq-rtfilter-module.zip
ENV JON_MODULE_ZIP2_NAME rhq-rtfilter-subsystem-module.zip

RUN mkdir -p $INSTALLDIR_EAP && \
	chown -R jboss.jboss  $HOME $INSTALLDIR_EAP

USER jboss

COPY software/* software/$EAP_PATCH_NAME $HOME/software/

RUN unzip $HOME/software/$EAP_ZIP_NAME -d $INSTALLDIR_EAP; \
       unzip $HOME/software/$JON_MODULE_ZIP1_NAME -d $INSTALLDIR_EAP/jboss-eap-6.4/modules/; \
       unzip $HOME/software/$JON_MODULE_ZIP2_NAME -d $INSTALLDIR_EAP/jboss-eap-6.4/modules/

COPY support/*.properties $INSTALLDIR_EAP/jboss-eap-6.4/standalone/configuration/
COPY support/*.xml        $INSTALLDIR_EAP/jboss-eap-6.4/standalone/configuration/
