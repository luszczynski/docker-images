FROM luszczynski/centos7-jon-agent

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

USER root

RUN yum -y install mariadb;yum clean all

RUN echo "mysqld_safe" >> $HOME/run.sh

EXPOSE 3306

CMD ["/home/jboss/run.sh"]