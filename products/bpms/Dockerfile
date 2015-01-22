FROM luszczynski/centos7-jon-agent

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

ENV INSTALLDIR_BPMS /opt/jboss/bpms

RUN mkdir -p $INSTALLDIR_BPMS;

COPY software/*.zip $SOFTWARE/
COPY support/install.xml $SUPPORT/

RUN unzip $SOFTWARE/jboss-eap-6.1.1.zip -d $INSTALLDIR_BPMS/ && \
	unzip -o $SOFTWARE/jboss-bpms-6.0.3.GA-redhat-1-deployable-eap6.x.zip -d $INSTALLDIR_BPMS

COPY support/*.properties $INSTALLDIR_BPMS/jboss-eap-6.1/standalone/configuration/

RUN chown -R jboss: $INSTALLDIR_BPMS/

USER root
RUN echo 'runuser -l jboss -c "$INSTALLDIR_BPMS/jboss-eap-6.1/bin/standalone.sh -c standalone.xml -b $MYIP -bmanagement $MYIP"' >> $HOME/run.sh

# Clean up
RUN rm -rf $SUPPORT && \
	rm -rf $SOFTWARE

EXPOSE 8080 9990

CMD ["/home/jboss/run.sh"]
