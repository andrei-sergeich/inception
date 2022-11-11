FROM debian:buster

ENV TZ=Europe/Moscow
#### PHP_VERSION не только в этом файле, при замене использовать поиск по проекту ####
ARG PHP_VERSION=7.3

RUN apt-get update -qq && \
    apt-get install -y \
    php${PHP_VERSION} \
    php${PHP_VERSION}-common \
#    php${PHP_VERSION}-session \
    php${PHP_VERSION}-iconv \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-mysqli \
    php${PHP_VERSION}-imap \
    php${PHP_VERSION}-cgi \
    php${PHP_VERSION}-pdo \
#    php${PHP_VERSION}-pdo_mysql \
    php${PHP_VERSION}-soap \
    php${PHP_VERSION}-posix \
    php${PHP_VERSION}-gettext \
    php${PHP_VERSION}-ldap \
    php${PHP_VERSION}-ctype \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-simplexml \
    wget htop tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN mkdir -p /var/www && \
    wget -O /var/www/index.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php && \
    chown -R root:root /var/www

EXPOSE 8080

CMD ["php", "-S", "[::]:8080", "-t", "/var/www"]
