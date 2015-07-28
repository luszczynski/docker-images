#FROM luszczynski/centos7-jon-agent
FROM rsoares/centos7-jon-agent-experiments

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>, Rafael T. C. Soares <rafaelcba@gmail.com>

RUN yum install -y postgresql-server postgresql-contrib; yum clean all

RUN \
  su -l postgres -c "/usr/bin/initdb -D '/var/lib/pgsql/data' --auth='ident'" >> /var/lib/pgsql/initdb.log 2>&1 < /dev/null;\
  sed -i 's/ident/trust/g'  /var/lib/pgsql/data/pg_hba.conf;\
  su -l postgres -c "pg_ctl -l server.log -w -D /var/lib/pgsql/data start";\
  psql -h 127.0.0.1 -p 5432 -U postgres --command="CREATE USER rhqadmin WITH password 'rhqadmin'";\
  createdb -h 127.0.0.1 -p 5432 -U postgres -O rhqadmin rhq;\
  echo "host all  all    0.0.0.0/0  md5" >> /var/lib/pgsql/data/pg_hba.conf;\  
  echo "listen_addresses='*'" >> /var/lib/pgsql/data/postgresql.conf;\
  su -l postgres -c "pg_ctl -l server.log -w -D /var/lib/pgsql/data stop"

RUN echo "su -l postgres -c 'pg_ctl -l server.log -w -D /var/lib/pgsql/data start; tail -F server.log'" >> $HOME/run.sh

EXPOSE 5432

CMD ["/home/jboss/run.sh"]
