FROM debian:buster

RUN apt-get update -qq && \
    apt-get install -y mariadb-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/db_up.sh /bin/db_up.sh

ARG DB_NAME=$DB_NAME
ARG DB_USER=$DB_USER
ARG DB_USER_PASSWORD=$DB_USER_PASSWORD
ARG DB_ROOT_PASSWORD=$DB_ROOT_PASSWORD

EXPOSE 3306

CMD ["bash", "/bin/db_up.sh"]
