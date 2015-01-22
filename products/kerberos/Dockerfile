FROM luszczynski/centos7-base

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

RUN yum -y install krb5-server krb5-libs ntp expect && \
	ntpdate 0.rhel.pool.ntp.org

COPY support/krb5.conf /etc/
COPY support/kdc.conf /var/kerberos/krb5kdc/kdc.conf
COPY support/kadm5.acl /var/kerberos/krb5kdc/kadm5.acl

RUN kdb5_util create -r CW.COM -s -P redhat



# https://gist.github.com/ashrithr/4767927948eca70845db
