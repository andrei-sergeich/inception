FROM debian:buster

ENV TZ=Europe/Moscow

RUN apt-get update -qq && \
    apt-get install -y mariadb-server tzdata htop && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/db_up.sh /usr/bin/db_up.sh

EXPOSE 3306

ENTRYPOINT ["bash", "/usr/bin/db_up.sh"]
CMD ["/usr/bin/mysqld_safe"]
