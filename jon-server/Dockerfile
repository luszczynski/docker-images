#######################################################################
#                                                                     #
# Creates a base CentOS image with JON Server 					      #
#                                                                     #
#######################################################################

FROM luszczynski/centos7:java-version

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

USER root

COPY software/*.zip $SOFTWARE/
COPY support/rhq-nodb-deploy.sh $SUPPORT/

RUN chmod +x $SUPPORT/rhq-nodb-deploy.sh

EXPOSE 7080

CMD ["$SUPPORT/rhq-nodb-deploy.sh"]
