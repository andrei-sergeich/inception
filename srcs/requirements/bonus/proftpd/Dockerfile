FROM debian:buster

ENV TZ=Europe/Moscow

RUN apt-get update -qq && \
    apt-get install -y \
    proftpd openssl htop tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN openssl req -x509 -nodes -newkey rsa:2048 \
    -keyout /etc/ssl/private/proftpd-selfsigned.key \
    -out /etc/ssl/certs/proftpd-selfsigned.crt \
    -subj "/C=RU/ST=Tatarstan/L=Kazan/O=21/OU=School/CN=cmero.42.fr"

COPY ./conf/cust_proftpd.conf /etc/proftpd/cust_proftpd.conf
COPY ./conf/cust_tls.conf /etc/proftpd/tls.conf
COPY ./tools/ftp_up.sh /usr/bin/start.sh

EXPOSE 20
EXPOSE 21

ENTRYPOINT ["bash", "/usr/bin/start.sh"]
CMD ["/usr/sbin/proftpd", "-n", "-c", "/etc/proftpd/cust_proftpd.conf"]
