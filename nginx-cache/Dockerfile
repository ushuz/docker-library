FROM nginx:mainline

COPY nginx.conf /etc/nginx/nginx.conf
COPY docker-entrypoint.sh /docker-entrypoint.sh

VOLUME ["/data/fetch-cache"]

ENTRYPOINT ["/docker-entrypoint.sh"]
