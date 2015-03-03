FROM luszczynski/centos7-eap

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

COPY support/*.xml $EAP_HOME/domain/configuration/

USER root
RUN echo 'runuser -l jboss -c "$EAP_HOME/bin/domain.sh -b $MYIP -bmanagement $MYIP -bunsecure $MYIP --host-config=host-master.xml"' >> $HOME/run.sh

# Clean up
RUN rm -rf $SUPPORT && \
	rm -rf $SOFTWARE

EXPOSE 8080 9990 9999

CMD ["/home/jboss/run.sh"]
