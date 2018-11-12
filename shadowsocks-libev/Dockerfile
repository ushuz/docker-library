FROM alpine:3.7

ARG SS_VER=3.2.1
ARG SS_URL=https://github.com/shadowsocks/shadowsocks-libev/releases/download/v$SS_VER/shadowsocks-libev-$SS_VER.tar.gz
ARG SS_DIR=shadowsocks-libev-$SS_VER

RUN set -ex \
    && apk update \
    && apk add --virtual .fetch-deps \
        openssl \
    && apk add --virtual .build-deps \
        build-base \
        c-ares-dev \
        libev-dev \
        libsodium-dev \
        linux-headers \
        mbedtls-dev \
        pcre-dev \
    && wget -O - $SS_URL | tar xz \
    && cd $SS_DIR \
        && ./configure --disable-documentation \
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

EXPOSE 80 443

CMD ss-server -s $SERVER_ADDR \
              -p $SERVER_PORT \
              -k ${PASSWORD:-$(hostname)} \
              -m $METHOD \
              -t $TIMEOUT \
              --fast-open \
              -d $DNS_ADDR \
              -u
