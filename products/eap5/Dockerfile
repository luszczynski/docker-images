FROM luszczynski/centos7-jon-agent

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

ENV EAP_ZIP_NAME jboss-eap-5.2.0.zip
ENV INSTALLDIR_EAP /opt/jboss/eap
ENV EAP_HOME $INSTALLDIR_EAP/jboss-eap-5.2

RUN mkdir -p $INSTALLDIR_EAP && \
	chown -R jboss.jboss  $HOME $INSTALLDIR_EAP $SOFTWARE

USER jboss

COPY software/$EAP_ZIP_NAME $SOFTWARE/

RUN unzip $HOME/software/$EAP_ZIP_NAME -d $INSTALLDIR_EAP/

USER root
RUN echo 'runuser -l jboss -c "$EAP_HOME/bin/run.sh -b $MYIP "' >> $HOME/run.sh

# Clean up
RUN rm -rf $SUPPORT && \
	rm -rf $SOFTWARE

EXPOSE 8080 9990 9999

CMD ["/home/jboss/run.sh"]