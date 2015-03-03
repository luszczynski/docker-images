FROM luszczynski/centos7-jon-agent

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

ENV EAP_PATCH_NAME jboss-eap-6.3.3-patch.zip
ENV EAP_ZIP_NAME jboss-eap-6.3.0.zip
ENV INSTALLDIR_EAP /opt/jboss/eap
ENV EAP_HOME $INSTALLDIR_EAP/jboss-eap-6.3

RUN mkdir -p $INSTALLDIR_EAP && \
	chown -R jboss.jboss  $HOME $INSTALLDIR_EAP $SOFTWARE

USER jboss

COPY software/$EAP_ZIP_NAME software/$EAP_PATCH_NAME $SOFTWARE/

RUN unzip $HOME/software/$EAP_ZIP_NAME -d $INSTALLDIR_EAP/
	
COPY support/*.properties $EAP_HOME/domain/configuration/
COPY support/*.xml $EAP_HOME/domain/configuration/

RUN $EAP_HOME/bin/jboss-cli.sh --user=admin --password=redhat@123 --controller=localhost "patch apply $SOFTWARE/$EAP_PATCH_NAME"

USER root
RUN echo 'runuser -l jboss -c "$EAP_HOME/bin/domain.sh -b $MYIP -bmanagement $MYIP -bunsecure $MYIP --host-config=host-master.xml"' >> $HOME/run.sh

# Clean up
RUN rm -rf $SUPPORT && \
	rm -rf $SOFTWARE

EXPOSE 8080 9990 9999

CMD ["/home/jboss/run.sh"]
