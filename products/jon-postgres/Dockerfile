FROM docker.io/centos/postgresql

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>, Rafael T. C. Soares <rafaelcba@gmail.com>

# install the JRE to run RHQ Agent
RUN yum install -y java-1.7.0-openjdk; yum clean all

ENV SOFTWARE_INSTALL_DIR /opt/redhat
ENV JAVA_HOME /usr/lib/jvm/jre

# install the RHQ/JON Agent to monitor the Postgres instance inside the container
COPY software/rhq-enterprise-agent-*.jar /tmp/
RUN java -jar /tmp/rhq-enterprise-agent-*.jar --install=$SOFTWARE_INSTALL_DIR
RUN rm /tmp/rhq-enterprise-agent-*.jar

COPY support/*.sh /

# RHQ Agent TCP port
EXPOSE 16163

ENTRYPOINT ["/run.sh"]
