#######################################################################
#                                                                     #
# Creates a base CentOS image with JON Server 					      #
#                                                                     #
#######################################################################

# Use the centos base image
FROM luszczynski/centos6:java-version

MAINTAINER gluszczy <gluszczy@redhat.com>

USER root

COPY software/*.zip $HOME/

ADD support/rhq-nodb-deploy.sh $HOME/rhq-nodb-deploy.sh

RUN chmod +x $HOME/rhq-nodb-deploy.sh

EXPOSE 7080

CMD $HOME/rhq-nodb-deploy.sh
