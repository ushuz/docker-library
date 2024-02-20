ARG MASTODON_VERSION=3.5.19
FROM tootsuite/mastodon:v${MASTODON_VERSION}

USER root
RUN mkdir -p /var/cache/apt/archives/partial && \
    apt update && \
    apt install -y --no-install-recommends patch && \
    rm -fr /var/cache/

USER mastodon
ADD patches /patches
RUN /usr/bin/patch -p0 < /patches/001-media_attachment.patch
RUN /usr/bin/patch -p0 < /patches/002-media_attachment_serializer.patch
