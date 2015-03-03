FROM luszczynski/centos7-jon-agent

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

ENV EAP_PATCH_NAME jboss-eap-6.3.3-patch.zip
ENV EAP_ZIP_NAME jboss-eap-6.3.0.zip
ENV INSTALLDIR_EAP /opt/jboss/eap
ENV EAP_HOME $INSTALLDIR_EAP/jboss-eap-6.3

RUN mkdir -p $INSTALLDIR_EAP && \
	chown -R jboss.jboss  $HOME $INSTALLDIR_EAP

USER jboss

COPY software/$EAP_ZIP_NAME software/$EAP_PATCH_NAME $HOME/software/

RUN unzip $HOME/software/$EAP_ZIP_NAME -d $INSTALLDIR_EAP

COPY support/*.properties $INSTALLDIR_EAP/jboss-eap-6.3/standalone/configuration/
COPY support/*.properties $INSTALLDIR_EAP/jboss-eap-6.3/domain/configuration/

RUN $INSTALLDIR_EAP/jboss-eap-6.3/bin/jboss-cli.sh --user=admin --password=redhat@123 --controller=localhost "patch apply $HOME/software/$EAP_PATCH_NAME"