ARG MASTODON_VERSION=3.5.3
FROM tootsuite/mastodon:v${MASTODON_VERSION}

# disable s3 acl to make it compatibible w/ cloudflare r2
RUN sed -i'' '/acl:/d' /opt/mastodon/vendor/bundle/ruby/3.0.0/gems/kt-paperclip-7.1.1/lib/paperclip/storage/s3.rb
