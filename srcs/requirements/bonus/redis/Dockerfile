FROM debian:buster

ENV TZ=Europe/Moscow

RUN apt-get update -qq && \
    apt-get install -y \
    redis-server php7.3-redis htop tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
#    && \
#    sed -i "s/bind 127.0.0.1/#bind 127.0.0.1/g"  /etc/redis/redis.conf && \
#    sed -i "s/# maxmemory <bytes>/maxmemory 20mb/g"  /etc/redis/redis.conf && \
#    echo "maxmemory-policy allkeys-lru" >> /etc/redis/redis.conf

COPY ./conf/redis.conf /etc/redis/redis.conf
#RUN chmod 640 /etc/redis/redis.conf

EXPOSE 6379

CMD ["redis-server", "--protected-mode", "no"]
#CMD [ "redis-server" , "/etc/redis/redis.conf" ]
# TODO проверить конфигурацию контейнера (открывать ли порт наружу, настройки)