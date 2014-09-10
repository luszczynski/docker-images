#######################################################################
#                                                                     #
# Creates a base CentOS image with Fuse				      #
#                                                                     #
#######################################################################

# Use the centos base image
FROM luszczynski/centos6:java-version

MAINTAINER gluszczy <gluszczy@redhat.com>

ENV HOME /home/jboss
ENV JAVA_HOME /usr/lib/jvm/jre

ADD software/jboss-fuse-full-6.1.0.redhat-379.zip $HOME/

RUN mkdir -p /opt/jboss/fuse

RUN unzip $HOME/jboss-fuse-full-6.1.0.redhat-379.zip -d /opt/jboss/fuse/

RUN sed -i "s/#admin/admin/" /opt/jboss/fuse/jboss-fuse-6.1.0.redhat-379/etc/users.properties

USER root
RUN echo "#!/bin/sh" >> $HOME/run.sh
RUN echo "service sshd start" >> $HOME/run.sh
RUN echo 'echo "Starting fuse..."' >> $HOME/run.sh
RUN echo '/opt/jboss/fuse/jboss-fuse-6.1.0.redhat-379/bin/start' >> $HOME/run.sh
RUN echo 'sleep 30' >> $HOME/run.sh
RUN echo 'echo "Fuse started"' >> $HOME/run.sh
RUN echo 'echo "Init fabric..."' >> $HOME/run.sh
RUN echo '/opt/jboss/fuse/jboss-fuse-6.1.0.redhat-379/bin/client -h 127.0.0.1 -a 8101 -u admin -p admin "fabric:create --wait-for-provisioning"' >> $HOME/run.sh
RUN echo 'tail -f /opt/jboss/fuse/jboss-fuse-6.1.0.redhat-379/data/log/karaf.log' >> $HOME/run.sh

RUN chmod +x $HOME/run.sh

RUN rm -rf $HOME/jboss-fuse-full-6.1.0.redhat-379.zip

EXPOSE 22 8181 8101

CMD /home/jboss/run.sh
