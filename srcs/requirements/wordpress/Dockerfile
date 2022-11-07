FROM debian:buster

ENV TZ=Europe/Moscow
ARG PHP_VERSION=7.3
ARG WP_VERSION=6.0.1

RUN apt-get update -qq && \
    apt-get install -y \
    php${PHP_VERSION} \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysql \
    mariadb-client \
    curl htop\
    sendmail \
    tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    mkdir -p /var/www/html/ && \
    curl -SL https://ru.wordpress.org/wordpress-${WP_VERSION}-ru_RU.tar.gz | \
    tar -xzC /var/www/html/

COPY ./conf/www.conf /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
COPY ./conf/wp-config.php /var/www/html/wordpress/wp-config.php
COPY ./tools/wp_up.sh /var/www/

EXPOSE 9000

ENTRYPOINT ["bash", "/var/www/wp_up.sh" ]
####    php-fpm${PHP_VERSION}   ####
CMD ["/usr/sbin/php-fpm7.3", "-F"]
