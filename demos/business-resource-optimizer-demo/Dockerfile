FROM luszczynski/centos7-brms

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

ENV BRMS_CONF $BRMS_HOME/standalone/configuration

COPY support/*.properties $BRMS_CONF/
COPY support/standalone.xml $BRMS_CONF/
COPY software/jboss-bpms-brms-6.0.3.GA-redhat-1-optaplanner.zip $SOFTWARE/jboss-bpms-brms-6.0.3.GA-redhat-1-optaplanner.zip

RUN unzip $SOFTWARE/jboss-bpms-brms-6.0.3.GA-redhat-1-optaplanner.zip -d $SOFTWARE/ && \
	cp -r $SOFTWARE/jboss-bpms-brms-6.0.3.GA-redhat-1-optaplanner/webexamples/binaries/optaplanner-webexamples-6.0.3-redhat-6.war $BRMS_HOME/standalone/deployments/

RUN chown -R jboss. $BRMS_HOME

EXPOSE 8080 9990

CMD ["/home/jboss/run.sh"]