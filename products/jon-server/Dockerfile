FROM rsoares/centos7-java-experiments
#FROM luszczynski/centos7-java

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>, Rafael T. C. Soares <rafaelcba@gmail.com>

ENV JON_VERSION=3.3.0.GA

COPY software/*.zip       /tmp/
COPY software/patch/*.zip /tmp/patch/

RUN /install_rhq.sh

COPY support/*.sh /

EXPOSE 7080

ENTRYPOINT ["/run.sh"]
