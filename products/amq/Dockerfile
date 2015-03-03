FROM luszczynski/centos7-jon-agent

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

ENV INSTALLDIR_AMQ /opt/jboss/amq
ENV AMQ_HOME $INSTALLDIR_AMQ/jboss-a-mq-6.1.0.redhat-379

RUN mkdir -p $INSTALLDIR_AMQ;

COPY software/*.zip $SOFTWARE/

RUN unzip -q -d $INSTALLDIR_AMQ $SOFTWARE/jboss-a-mq-6.1.0.redhat-379.zip

RUN chown -R jboss: $INSTALLDIR_AMQ/

USER root
RUN echo 'runuser -l jboss -c "AMQ_HOME/bin/amq"' >> $HOME/run.sh

# Clean up
RUN rm -rf $SUPPORT && \
	rm -rf $SOFTWARE

CMD ["/home/jboss/run.sh"]