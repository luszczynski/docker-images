FROM luszczynski/centos7-jon-agent

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

RUN yum install -y http://dl.fedoraproject.org/pub/epel/7/x86_64/i/incron-0.5.10-8.el7.x86_64.rpm dnsmasq && \
	yum clean all

RUN echo "port=53" > /etc/dnsmasq.conf && \
	echo "bind-interfaces" >> /etc/dnsmasq.conf && \
	echo "resolv-file=/etc/resolv.dnsmasq.conf" >> /etc/dnsmasq.conf && \
	echo "addn-hosts=/dnsmasq.hosts" >> /etc/dnsmasq.conf && \
	echo "expand-hosts" >> /etc/dnsmasq.conf && \
	echo "domain=testdomain.local" >> /etc/dnsmasq.conf && \
	echo "log-queries" >> /etc/dnsmasq.conf && \
	echo "nameserver 8.8.8.8" >> /etc/resolv.dnsmasq.conf

RUN	echo 'root' >> /etc/incron.allow && \
	echo "/dnsmasq.hosts IN_CREATE,IN_DELETE,IN_MODIFY pkill -HUP dnsmasq" > /var/spool/incron/root

RUN echo "rm -rf /var/spool/incron/root/*" >> $HOME/run.sh && \
	echo "/usr/sbin/incrond" >> $HOME/run.sh && \
	echo "/usr/sbin/dnsmasq -d" >> $HOME/run.sh

EXPOSE 53

CMD ["/home/jboss/run.sh"]