# Use the centos base image
FROM centos:centos7

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

RUN yum -y update; yum -y install unzip sudo vim xterm net-tools openssh-server; yum clean all

# Increase ulimit
RUN echo "* soft nofile 4096" >> /etc/security/limits.conf && \
	echo "* hard nofile 4096" >> /etc/security/limits.conf

RUN alias ls="ls --color" && \
	alias grep="grep --color=auto" && \
	alias ll="ls -l --color=auto"

ENV TERM xterm
ENV HOME /home/jboss
ENV SUPPORT $HOME/support
ENV SOFTWARE $HOME/software

VOLUME /dnsmasq.hosts

############################################
# Creating user jboss
############################################
RUN echo '%jboss ALL=(ALL) ALL' >> /etc/sudoers && \
	useradd -m -d /home/jboss -p jboss jboss  && \
	echo 'root:redhat' | chpasswd && \
	mkdir -p $SOFTWARE && mkdir -p $SUPPORT

ONBUILD RUN echo "#!/bin/sh" > $HOME/run.sh && \
			echo 'while [ "x$MYIP" == "x" ]; do' >> $HOME/run.sh && \
			echo 'MYIP=$(ip addr | grep "state UP" -A2 | tail -n1 | awk '\''{print $2}'\'' | cut -f1  -d'\''/'\'')' >> $HOME/run.sh && \
			echo "done" >> $HOME/run.sh && \
			echo 'echo "$MYIP $(hostname)" > /dnsmasq.hosts/0host_$(hostname)' >> $HOME/run.sh && \
			echo "echo 0 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts" >> $HOME/run.sh && \
			echo "" >> $HOME/run.sh && \
			chmod +x $HOME/run.sh