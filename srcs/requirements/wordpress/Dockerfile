FROM debian:buster

RUN apt-get update -qq && \
    apt-get install -y php7.3 php-mysqli php-fpm mariadb-client curl sendmail && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    mkdir -p /var/www/html/ && \
    curl -SL https://ru.wordpress.org/wordpress-6.0.1-ru_RU.tar.gz | \
    tar -xzC /var/www/html/

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf
COPY ./conf/wp-config.php /var/www/html/wordpress/wp-config.php
COPY ./tools/wp_up.sh /var/www/

EXPOSE 9000

CMD ["bash", "/var/www/wp_up.sh"]
