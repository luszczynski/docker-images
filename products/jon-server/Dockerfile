FROM luszczynski/centos7-java

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

USER root

COPY software/*.zip $SOFTWARE/
COPY support/rhq-nodb-deploy.sh $SUPPORT/

RUN chmod +x $SUPPORT/rhq-nodb-deploy.sh

EXPOSE 7080

CMD ["/home/jboss/support/rhq-nodb-deploy.sh"]
