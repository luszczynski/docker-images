#######################################################################
#                                                                     #
# Creates a base CentOS image with Apache and Mod cluster	      #
#                                                                     #
#######################################################################

# Use the centos base image
FROM centos:centos6

MAINTAINER gluszczy <gluszczy@redhat.com>

RUN yum -y update; yum -y install httpd which telnet unzip openssh-server sudo openssh-clients vim;yum clean all

ENV HOME /root

USER root
RUN echo 'root:redhat' |chpasswd
RUN mkdir /tmp/software

ADD software/jboss-eap-native-webserver-connectors-6.3.0-RHEL6-x86_64.zip /tmp/software/

ADD support/httpd.conf /etc/httpd/conf/
ADD support/mod_cluster.conf /etc/httpd/conf.d/

RUN unzip /tmp/software/jboss-eap-native-webserver-connectors-6.3.0-RHEL6-x86_64.zip -d /tmp/

RUN cp /tmp/jboss-eap-6.3/modules/system/layers/base/native/lib64/httpd/modules/mod_slotmem.so /etc/httpd/modules/
RUN cp /tmp/jboss-eap-6.3/modules/system/layers/base/native/lib64/httpd/modules/mod_proxy_cluster.so /etc/httpd/modules/
RUN cp /tmp/jboss-eap-6.3/modules/system/layers/base/native/lib64/httpd/modules/mod_manager.so /etc/httpd/modules/
RUN cp /tmp/jboss-eap-6.3/modules/system/layers/base/native/lib64/httpd/modules/mod_advertise.so /etc/httpd/modules/

RUN echo "alias ll='ls -l --color=auto'" >> $HOME/.bash_profile
RUN echo "alias grep='grep --color=auto'" >> $HOME/.bash_profile

# start.sh
USER root
RUN echo "#!/bin/sh" >> $HOME/run.sh
RUN echo 'sed -i "s/ip_apache/$(hostname -i)/g" /etc/httpd/conf.d/mod_cluster.conf' >> $HOME/run.sh
RUN echo 'sed -i "s/ip_virtualhost_apache/$(hostname -i)/g" /etc/httpd/conf.d/mod_cluster.conf' >> $HOME/run.sh
RUN echo "echo Apache Start script" >> $HOME/run.sh
RUN echo "service sshd start " >> $HOME/run.sh
RUN echo "echo 0 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts" >> $HOME/run.sh
RUN echo "/usr/sbin/apachectl -D FOREGROUND" >> $HOME/run.sh
RUN chmod +x $HOME/run.sh

# Clean up
RUN rm -rf /tmp/software

EXPOSE 22 80 6666

CMD /root/run.sh
