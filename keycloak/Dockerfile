#######################################################################
#                                                                     #
# Creates a base CentOS image with Keycloak Server				  	  #
#                                                                     #
#######################################################################

# Use the centos base image
FROM luszczynski/centos6:java-version

MAINTAINER gluszczy <gluszczy@redhat.com>

ENV JAVA_HOME /usr/lib/jvm/jre
ENV HOME /home/jboss
ENV SUPPORT $HOME/support
ENV SOFTWARE $HOME/software
ENV INSTALLDIR_KEYCLOAK /opt/jboss/keycloak
ENV SOFTWARE_NAME keycloak-appliance-dist-all-1.0.2.Final.zip


RUN mkdir -p $SOFTWARE; mkdir -p $SUPPORT; mkdir -p $INSTALLDIR_KEYCLOAK;

COPY software/$SOFTWARE_NAME $SOFTWARE/
RUN unzip $SOFTWARE/$SOFTWARE_NAME -d $INSTALLDIR_KEYCLOAK/

# Command line shortcuts
RUN echo "alias ll='ls -l --color=auto'" >> $HOME/.bash_profile
RUN echo "alias grep='grep --color=auto'" >> $HOME/.bash_profile

RUN chown -R jboss: $INSTALLDIR_KEYCLOAK/

# start.sh
USER root
RUN echo "#!/bin/sh" >> $HOME/run.sh
RUN echo "echo JBoss Keycloak Start script" >> $HOME/run.sh
RUN echo "service sshd start " >> $HOME/run.sh
RUN echo "echo 0 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts" >> $HOME/run.sh
RUN echo "runuser -l jboss -c '$INSTALLDIR_KEYCLOAK/keycloak-appliance-dist-all-1.0.2.Final/keycloak/bin/standalone.sh -c standalone.xml -b 0.0.0.0 -bmanagement 0.0.0.0'" >> $HOME/run.sh
RUN chmod +x $HOME/run.sh

# Clean up
RUN rm -rf $SUPPORT
RUN rm -rf $SOFTWARE

EXPOSE 22 8080 9990

CMD /home/jboss/run.sh
