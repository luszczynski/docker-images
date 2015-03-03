FROM luszczynski/centos7-eap-standalone

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

ENV EAP_CONF $EAP_HOME/standalone/configuration

COPY support/*.properties support/standalone.xml $EAP_CONF/
COPY software/jboss-bpms-brms-6.0.3.GA-redhat-1-optaplanner.zip $SOFTWARE/jboss-bpms-brms-6.0.3.GA-redhat-1-optaplanner.zip

RUN unzip $SOFTWARE/jboss-bpms-brms-6.0.3.GA-redhat-1-optaplanner.zip -d $SOFTWARE/ && \
	cp -r $SOFTWARE/jboss-bpms-brms-6.0.3.GA-redhat-1-optaplanner/webexamples/binaries/optaplanner-webexamples-6.0.3-redhat-6.war $EAP_HOME/standalone/deployments/

RUN chown -R jboss. $EAP_HOME

EXPOSE 8080 9990