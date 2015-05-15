FROM luszczynski/centos7-java

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

USER root

COPY software/* $SOFTWARE/
COPY software/patch/* $SOFTWARE/patch/
COPY support/*.sh $SUPPORT/

RUN chmod +x $SUPPORT/*.sh

EXPOSE 7080

CMD ["/home/jboss/support/rhq-nodb-deploy.sh"]
