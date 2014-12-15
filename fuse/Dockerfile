#######################################################################
#                                                                     #
# Creates a base CentOS image with Fuse				 			      #
#                                                                     #
#######################################################################

FROM luszczynski/centos7:jon-agent

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

COPY software/jboss-fuse-full-6.1.0.redhat-379.zip $HOME/

RUN mkdir -p /opt/jboss/fuse && \
	unzip $HOME/jboss-fuse-full-6.1.0.redhat-379.zip -d /opt/jboss/fuse/ && \
	sed -i "s/#admin/admin/" /opt/jboss/fuse/jboss-fuse-6.1.0.redhat-379/etc/users.properties

USER root
RUN echo 'echo "Starting fuse..."' >> $HOME/run.sh && \
	echo '/opt/jboss/fuse/jboss-fuse-6.1.0.redhat-379/bin/start' >> $HOME/run.sh && \
	echo 'sleep 30' >> $HOME/run.sh && \
	echo 'echo "Fuse started"' >> $HOME/run.sh && \
	echo 'echo "Init fabric..."' >> $HOME/run.sh && \
	echo '/opt/jboss/fuse/jboss-fuse-6.1.0.redhat-379/bin/client -h 127.0.0.1 -a 8101 -u admin -p admin "fabric:create --wait-for-provisioning"' >> $HOME/run.sh && \
	echo 'tail -f /opt/jboss/fuse/jboss-fuse-6.1.0.redhat-379/data/log/karaf.log' >> $HOME/run.sh

RUN chmod +x $HOME/run.sh && \
	rm -rf $HOME/jboss-fuse-full-6.1.0.redhat-379.zip

EXPOSE 8181 8101

CMD ["/home/jboss/run.sh"]
