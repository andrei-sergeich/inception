FROM debian:buster

ENV TZ=Europe/Moscow

RUN apt-get update -qq && \
    apt-get install -y \
    nginx openssl php-gd php-xml tzdata htop && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN openssl req -x509 -nodes -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=RU/ST=Tatarstan/L=Kazan/O=21/OU=School/CN=cmero.42.fr"

COPY ./conf/site.conf /etc/nginx/sites-enabled/default
COPY ./tools/ /var/www/html/shop/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
