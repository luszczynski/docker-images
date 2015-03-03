FROM luszczynski/centos7-eap

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

COPY support/host-slave.xml $EAP_HOME/domain/configuration/

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
