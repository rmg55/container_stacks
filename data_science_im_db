FROM rowangaffney/data_science_im_rs

USER $NB_UID

LABEL maintainer="Rowan Gaffney <rowan.gaffney@ars.usda.gov>"

USER root

RUN apt-get update -y && \
    apt-get upgrade -y &&\
    apt-get install -y \
    postgresql \
    postgresql-contrib \
    postgis \
    postgresql-10-ogr-fdw \
    libpq-dev
    

RUN mkdir /mnt/ssd
RUN mkdir /mnt/ssd/postgresql
RUN mkdir /mnt/ssd/postgresql/docker_postgres

USER root
RUN chown -R postgres:postgres /mnt/ssd/postgresql/docker_postgres
RUN chown -R postgres:postgres /var/run/postgresql

USER postgres
#RUN pg_bin_dir=$(/usr/bin/pg_config --bindir)
#RUN echo $pg_bin_dir
#RUN echo $PATH
RUN pg_bin_dir=$(/usr/bin/pg_config --bindir) && \
    $CMD $pg_bin_dir/pg_ctl initdb -D /mnt/ssd/postgresql/docker_postgres/ && \
    $CMD $pg_bin_dir/pg_ctl -o "-p 5444" start -D /mnt/ssd/postgresql/docker_postgres/ -l /mnt/ssd/postgresql/docker_postgres/serverlog && \
    /usr/bin/psql -p 5444 --command "CREATE USER rrsru_admin WITH SUPERUSER PASSWORD 'grass4beef';" && \
    /usr/bin/createdb -p 5444 -O rrsru_admin cper && \
    echo "listen_addresses='*'" >> /etc/postgresql/10/main/postgresql.conf
    

#RUN pg_bin_dir=$(/usr/bin/pg_config --bindir) && $CMD $pg_bin_dir/pg_ctl -o "-p 5444" start -D /mnt/ssd/postgresql/docker_postgres/ -l /mnt/ssd/postgresql/docker_postgres/serverlog
#RUN /usr/bin/createdb -p 5444 -O rrsru_admin cper

#RUN echo "listen_addresses='*'" >> /etc/postgresql/10/main/postgresql.conf

USER root
EXPOSE 5444

#CMD ["/usr/lib/postgresql/10/bin/postgres", "-D", "/mnt/ssd/postgresql/docker_postgres/main", "-c", "config_file=/etc/postgresql/10/main/postgresql.conf"]
 


#RUN /etc/init.d/postgresql start &&\
#    psql --command "CREATE USER rrsru_admin WITH SUPERUSER PASSWORD '';" &&\
#    createdb -O rrsru_admin cper

## Adjust PostgreSQL configuration so that remote connections to the
## database are possible.
#RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/10/main/pg_hba.conf

## And add ``listen_addresses`` to ``/etc/postgresql/11/main/postgresql.conf``
#RUN echo "listen_addresses='*'" >> /etc/postgresql/11/main/postgresql.conf

## Expose the PostgreSQL port
#EXPOSE 5432

## Add VOLUMEs to allow backup of config, logs and databases
#VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

## Set the default command to run when starting the container
USER postgres
CMD ["/usr/lib/postgresql/10/bin/pg_ctl","start", "-D", "/mnt/ssd/postgresql/docker_postgres", "-l", "/mnt/ssd/postgresql/docker_postgres/serverlog"]

USER $NB_UID
