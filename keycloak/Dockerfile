#######################################################################
#                                                                     #
# Creates a base CentOS image with Keycloak Server				  	  #
#                                                                     #
#######################################################################

FROM luszczynski/centos7:jon-agent

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

ENV INSTALLDIR_KEYCLOAK /opt/jboss/keycloak
ENV SOFTWARE_NAME keycloak-appliance-dist-all-1.1.0.Beta2.zip

RUN mkdir -p $INSTALLDIR_KEYCLOAK;

COPY software/$SOFTWARE_NAME $SOFTWARE/
RUN unzip $SOFTWARE/$SOFTWARE_NAME -d $INSTALLDIR_KEYCLOAK/ && \
	chown -R jboss: $INSTALLDIR_KEYCLOAK/

# start.sh
USER root
RUN echo 'runuser -l jboss -c "$INSTALLDIR_KEYCLOAK/keycloak-appliance-dist-all-1.1.0.Beta2/keycloak/bin/standalone.sh -c standalone.xml -b $MYIP -bmanagement $MYIP"' >> $HOME/run.sh

# Clean up
RUN rm -rf $SUPPORT && rm -rf $SOFTWARE

EXPOSE 8080 9990

CMD ["/home/jboss/run.sh"]