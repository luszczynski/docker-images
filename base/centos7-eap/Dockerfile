#FROM luszczynski/centos7-jon-agent
FROM rsoares/centos7-jon-agent-experiments

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>, Rafael T. C. Soares <rafaelcba@gmail.com>

ENV EAP_VERSION=6.4.0
ENV EAP_ZIP_NAME jboss-eap-$EAP_VERSION.zip
ENV EAP_HOME $INSTALLDIR_EAP/jboss-eap-6.4
ENV JON_MODULE_ZIP1_NAME rhq-rtfilter-module.zip
ENV JON_MODULE_ZIP2_NAME rhq-rtfilter-subsystem-module.zip

RUN mkdir -p $INSTALL_DIR_EAP && \
    chown -R jboss.jboss  $HOME $INSTALL_DIR_EAP

USER jboss

COPY software/* $HOME/software/
COPY software/patch/*.zip /tmp/software/patch/
COPY support/*.sh /

RUN unzip $HOME/software/$EAP_ZIP_NAME -d $INSTALL_DIR_EAP; \
    unzip $HOME/software/$JON_MODULE_ZIP1_NAME -d $EAP_HOME/modules/; \
    unzip $HOME/software/$JON_MODULE_ZIP2_NAME -d $EAP_HOME/modules/

COPY support/*.properties $EAP_HOME/standalone/configuration/
COPY support/*.xml        $EAP_HOME/standalone/configuration/
