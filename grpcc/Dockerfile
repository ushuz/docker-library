FROM node:alpine

ARG GRPCC_VERSION=1.1.3

RUN set -ex \
    && npm install --global --unsafe-perm "grpcc@${GRPCC_VERSION}" \
    && npm cache clean --force

ENTRYPOINT ["grpcc"]
