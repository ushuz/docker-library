FROM python:alpine

ARG PGCLI_VERSION=4.0.1

RUN set -ex \
    && apk add --no-cache less \
    && pip install --no-cache-dir \
        "pendulum==3.0.0b1" \
        "psycopg[binary]<3.2" \
        "pgcli==$PGCLI_VERSION"

ENTRYPOINT ["pgcli"]

CMD ["--help"]
