FROM nginx:mainline

COPY nginx.conf /etc/nginx/nginx.conf
COPY docker-entrypoint.sh /docker-entrypoint.sh

ENV FETCH_UPSTREAM=

VOLUME ["/data/fetch-cache"]

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
