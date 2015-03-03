FROM centos:centos7

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

ENV TERM=xterm HOME=/home/jboss SUPPORT=$HOME/support SOFTWARE=$HOME/software MAVEN_VERSION=3.2.5 M2_HOME=$HOME/.m2

RUN yum -y update; yum -y install unzip sudo vim xterm net-tools openssh-server wget git; yum clean all

RUN curl -sSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar 	xzf - -C /usr/share && \
	mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven && \
	ln -s /usr/share/maven/bin/mvn /usr/bin/mvn && \
	chown -R jboss. M2_HOME

# Increase ulimit
RUN echo "* soft nofile 4096" >> /etc/security/limits.conf && \
	echo "* hard nofile 4096" >> /etc/security/limits.conf

RUN alias ls="ls --color" && \
	alias grep="grep --color=auto" && \
	alias ll="ls -l --color=auto"

VOLUME /dnsmasq.hosts

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