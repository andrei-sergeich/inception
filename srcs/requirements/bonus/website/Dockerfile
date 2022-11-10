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

#COPY ./conf/site.conf /etc/nginx/sites-available/site.conf
COPY ./conf/site.conf /etc/nginx/sites-enabled/default
#RUN ln -s /etc/nginx/sites-available/site.conf /etc/nginx/sites-enabled/site.conf
#RUN rm /etc/nginx/sites-enabled/default
COPY ./tools/ /var/www/html/shop/
#COPY ./tools/site_up.sh /usr/bin/site_up.sh

EXPOSE 443

#ENTRYPOINT ["bash", "/usr/bin/site_up.sh"]
CMD ["nginx", "-g", "daemon off;"]
