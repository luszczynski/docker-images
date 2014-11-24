#######################################################################
#                                                                     #
# Creates a base CentOS image with Apache and Mod cluster	     	  #
#                                                                     #
#######################################################################

# Use the centos base image
FROM luszczynski/centos6:java-version

MAINTAINER gluszczy <gluszczy@redhat.com>

RUN yum -y install httpd;yum clean all

COPY software/*.zip $SOFTWARE/
COPY support/httpd.conf /etc/httpd/conf/
COPY support/mod_cluster.conf /etc/httpd/conf.d/

RUN unzip $SOFTWARE/jboss-eap-native-webserver-connectors-6.3.0-RHEL6-x86_64.zip -d /tmp/ && \
	cp /tmp/jboss-eap-6.3/modules/system/layers/base/native/lib64/httpd/modules/mod_slotmem.so /etc/httpd/modules/ && \
	cp /tmp/jboss-eap-6.3/modules/system/layers/base/native/lib64/httpd/modules/mod_proxy_cluster.so /etc/httpd/modules/ && \
	cp /tmp/jboss-eap-6.3/modules/system/layers/base/native/lib64/httpd/modules/mod_manager.so /etc/httpd/modules/ && \
	cp /tmp/jboss-eap-6.3/modules/system/layers/base/native/lib64/httpd/modules/mod_advertise.so /etc/httpd/modules/ && \
	rm -rf $SOFTWARE

# start.sh
USER root
RUN echo "#!/bin/sh" >> $HOME/run.sh && \
	echo 'sed -i "s/ip_apache/$(hostname -i)/g" /etc/httpd/conf.d/mod_cluster.conf' >> $HOME/run.sh && \
	echo 'sed -i "s/ip_virtualhost_apache/$(hostname -i)/g" /etc/httpd/conf.d/mod_cluster.conf' >> $HOME/run.sh && \
	echo "echo Apache Start script" >> $HOME/run.sh && \
	echo "echo 0 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts" >> $HOME/run.sh && \
	echo "/usr/sbin/apachectl -D FOREGROUND" >> $HOME/run.sh && \
	chmod +x $HOME/run.sh

EXPOSE 80 6666

CMD /home/jboss/run.sh
