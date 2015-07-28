FROM rsoares/centos7-jon-agent-experiments

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>, Rafael T. C. Soares <rafaelcba@gmail.com>

ENV EAP_VERSION=6.4
ENV JBOSS_HOME=$SOFTWARE_INSTALL_DIR/jboss-eap-$EAP_VERSION

# Create the wildfly user and group
#RUN groupadd -f r jboss -g 433 && \
#    useradd -u 431 -r -g jboss -d /opt/redhat \
#    -s /sbin/nologin -c "JBoss EAP admin user" jboss

RUN chown -R jboss.jboss $SOFTWARE_INSTALL_DIR

USER jboss

COPY software/*.zip /tmp/
COPY software/patch/*.zip /tmp/patch/
COPY software/modules/*.zip /tmp/modules/

RUN unzip -q /tmp/jboss-eap-*.zip -d $SOFTWARE_INSTALL_DIR

COPY support/*.sh /
RUN /applyPatch.sh

COPY support/*.properties $EAP_HOME/standalone/configuration/
COPY support/*.xml        $EAP_HOME/standalone/configuration/

EXPOSE 8080 9990

ENTRYPOINT ["/run.sh"] 
