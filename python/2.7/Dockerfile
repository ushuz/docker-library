FROM alpine:latest

RUN set -ex \
    && fetchDeps='openssl' \
    && apk add --no-cache $fetchDeps python \
    && wget -O - 'https://bootstrap.pypa.io/get-pip.py' | python2 \
    && pip install --no-cache-dir virtualenv \
    && apk del --purge $fetchDeps

CMD ["python2"]
