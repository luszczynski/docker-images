FROM luszczynski/centos7-jon-agent

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

ENV EAP_PATCH_NAME jboss-eap-6.3.2-patch.zip
ENV EAP_ZIP_NAME jboss-eap-6.3.0.zip
ENV INSTALLDIR_EAP /opt/jboss/eap
ENV EAP_HOME $INSTALLDIR_EAP/jboss-eap-6.3

RUN mkdir -p $INSTALLDIR_EAP && \
	chown -R jboss.jboss  $HOME $INSTALLDIR_EAP

USER jboss

COPY software/$EAP_PATCH_NAME software/$EAP_ZIP_NAME $SOFTWARE/

RUN unzip $SOFTWARE/$EAP_ZIP_NAME -d $INSTALLDIR_EAP/

COPY support/host-slave.xml support/*.properties $EAP_HOME/domain/configuration/

RUN $EAP_HOME/bin/jboss-cli.sh --user=admin --password=redhat@123 --controller=localhost "patch apply $HOME/software/$EAP_PATCH_NAME"

USER root
RUN echo 'if [ "$#" -ne 1 ]; then' >> $HOME/run.sh && \
	echo 'echo "Usage: $0 [host-controller name]" >&2' >> $HOME/run.sh && \
	echo 'exit 1' >> $HOME/run.sh && \
	echo 'fi' >> $HOME/run.sh && \
	echo 'sed -i '\''s/name=""/name='\''\"$1\"'\''/g'\'' $EAP_HOME/domain/configuration/host-slave.xml' >> $HOME/run.sh && \
	echo 'sed -i '\''s/ip_jgroups/'\''$MYIP'\''/g'\'' $EAP_HOME/domain/configuration/host-slave.xml' >> $HOME/run.sh && \
	echo 'runuser -l jboss -c "$EAP_HOME/bin/domain.sh --host-config=host-slave.xml --master-address=eap-domain -b 0.0.0.0 -bmanagement $MYIP -bunsecure $MYIP"' >> $HOME/run.sh

RUN chown -R jboss. $EAP_HOME

# Clean up
RUN rm -rf $SUPPORT && rm -rf $SOFTWARE

EXPOSE 8080 9990 9999

ENTRYPOINT ["/home/jboss/run.sh"]
