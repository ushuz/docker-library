FROM ushuz/python:2

ARG MYCLI_VERSION=1.8.1

RUN set -ex \
    && apk add --no-cache less \
    && apk add --no-cache --virtual .build-deps python-dev build-base \
    && pip install --no-cache-dir mycli==$MYCLI_VERSION \
    && apk del --purge .build-deps

ENTRYPOINT ["mycli"]

CMD ["--help"]
