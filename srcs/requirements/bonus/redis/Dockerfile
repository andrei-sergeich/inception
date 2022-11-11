FROM debian:buster

ENV TZ=Europe/Moscow
#### PHP_VERSION не только в этом файле, при замене использовать поиск по проекту ####
ARG PHP_VERSION=7.3

RUN apt-get update -qq && \
    apt-get install -y \
    redis-server php${PHP_VERSION}-redis htop tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./conf/redis.conf /etc/redis/redis.conf

EXPOSE 6379

CMD ["redis-server", "--protected-mode", "no"]
