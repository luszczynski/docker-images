FROM luszczynski/centos7-jon-agent

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

ENV INSTALLDIR_BRMS=/opt/jboss/brms BRMS_HOME=$INSTALLDIR_BRMS/jboss-eap-6.1

RUN mkdir -p $INSTALLDIR_BRMS;

COPY software/*.zip $SOFTWARE/

RUN unzip $SOFTWARE/jboss-eap-6.1.1.zip -d $INSTALLDIR_BRMS/ && \
	unzip -o $SOFTWARE/jboss-brms-6.0.3.GA-redhat-1-deployable-eap6.x.zip -d $INSTALLDIR_BRMS

COPY support/*.properties $BRMS_HOME/standalone/configuration/

RUN chown -R jboss: $INSTALLDIR_BRMS/

USER root
RUN echo 'runuser -l jboss -c "$BRMS_HOME/bin/standalone.sh -c standalone.xml -b $MYIP -bmanagement $MYIP"' >> $HOME/run.sh

# Clean up
RUN rm -rf $SUPPORT && \
	rm -rf $SOFTWARE

EXPOSE 8080 9990

CMD ["/home/jboss/run.sh"]
