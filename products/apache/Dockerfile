FROM luszczynski/centos7-jon-agent

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

RUN yum install -y apr-util httpd && \
	yum clean all

USER root
RUN echo "apachectl -D FOREGROUND" >> $HOME/run.sh

EXPOSE 80

CMD ["/home/jboss/run.sh"]