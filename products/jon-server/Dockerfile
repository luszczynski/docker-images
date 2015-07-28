FROM rsoares/centos7-java-experiments
#FROM luszczynski/centos7-java

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>, Rafael T. C. Soares <rafaelcba@gmail.com>

COPY software/*.zip /tmp/
COPY software/patch/* /tmp/patch/
COPY support/*.sh /

RUN /install_rhq.sh

EXPOSE 7080

ENTRYPOINT ["/run.sh"]
