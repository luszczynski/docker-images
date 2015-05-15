FROM luszczynski/centos7-eap

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

USER root
RUN echo 'runuser -l jboss -c "exec $EAP_HOME/bin/standalone.sh -c standalone-full-ha.xml -b 0.0.0.0 -bmanagement $MYIP -bunsecure $MYIP $@"' >> $HOME/run.sh

# Clean up
RUN rm -rf $SUPPORT && rm -rf $SOFTWARE

EXPOSE 8080 9990 9999

ENTRYPOINT ["/home/jboss/run.sh"]
