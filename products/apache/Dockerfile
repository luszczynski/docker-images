FROM luszczynski/centos7-jon-agent

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>

ENV EWS_INSTALL_DIR /opt/jboss/ews

RUN mkdir -p $EWS_INSTALL_DIR

RUN yum install -y apr-util mailcap && \
	yum clean all

RUN	useradd -c "Apache" -u 48 -s /bin/sh -r apache
	#su -m -c "./sbin/apachectl start"

COPY software/*.zip $SOFTWARE/
#COPY support/httpd.conf /etc/httpd/conf/

RUN unzip $SOFTWARE/jboss-ews-httpd-2.1.0-RHEL7-x86_64.zip -d $EWS_INSTALL_DIR/ && \
	unzip $SOFTWARE/jboss-eap-native-webserver-connectors-6.3.0-RHEL7-x86_64.zip -d $SOFTWARE/

RUN rm -rf $EWS_INSTALL_DIR/jboss-ews-2.1/httpd/conf.d/*
COPY support/mod_cluster.conf $EWS_INSTALL_DIR/jboss-ews-2.1/httpd/conf.d/

RUN cp $SOFTWARE/jboss-eap-6.3/modules/system/layers/base/native/lib64/httpd/modules/*.so $EWS_INSTALL_DIR/jboss-ews-2.1/httpd/modules/ && \
	cd $EWS_INSTALL_DIR/jboss-ews-2.1/httpd/ && ./.postinstall && \
	chown -R apache: $EWS_INSTALL_DIR

# start.sh
USER root
RUN echo 'sed -i "s/ip_apache/$MYIP/g" $EWS_INSTALL_DIR/jboss-ews-2.1/httpd/conf.d/mod_cluster.conf' >> $HOME/run.sh && \
	echo 'sed -i "s/ip_virtualhost_apache/$MYIP/g" $EWS_INSTALL_DIR/jboss-ews-2.1/httpd/conf.d/mod_cluster.conf' >> $HOME/run.sh && \
	echo "cd $EWS_INSTALL_DIR/jboss-ews-2.1/httpd/sbin/ && ./apachectl -D FOREGROUND" >> $HOME/run.sh

EXPOSE 80 6666

CMD ["/home/jboss/run.sh"]