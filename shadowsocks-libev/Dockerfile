FROM alpine:latest

MAINTAINER John Hu <hszqqq12@gmail.com>

ARG SS_VER=2.5.6
ARG SS_URL=https://github.com/shadowsocks/shadowsocks-libev/archive/v$SS_VER.tar.gz
ARG SS_DIR=shadowsocks-libev-$SS_VER

RUN set -ex \
    && apk update \
    && apk add --virtual .fetch-deps \
        openssl \
    && apk add --virtual .build-deps \
        build-base \
        libev-dev \
        libsodium-dev \
        linux-headers \
        openssl-dev \
        pcre-dev \
        udns-dev \
    && wget -O - $SS_URL | tar xz \
    && cd $SS_DIR \
        && ./configure --enable-system-shared-lib --disable-documentation \
        && make install \
        && cd .. \
    && runDeps="$( \
      scanelf --needed --nobanner --recursive /usr/local \
        | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
        | xargs -r apk info --installed \
        | sort -u \
    )" \
    && apk add --virtual .run-deps $runDeps \
    && apk del --purge .fetch-deps .build-deps \
    && rm -rf $SS_DIR /var/cache/apk/*

ENV SERVER_ADDR 0.0.0.0
ENV SERVER_PORT 8388
ENV PASSWORD=
ENV METHOD      aes-256-cfb
ENV TIMEOUT     300
ENV DNS_ADDR    8.8.8.8

EXPOSE $SERVER_PORT

CMD ss-server -s $SERVER_ADDR \
              -p $SERVER_PORT \
              -k ${PASSWORD:-$(hostname)} \
              -m $METHOD \
              -t $TIMEOUT \
              --fast-open \
              -d $DNS_ADDR \
              -u
