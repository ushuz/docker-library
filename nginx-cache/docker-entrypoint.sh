#!/bin/bash

# ensure $FETCH_UPSTREAM env
if [ -z $FETCH_UPSTREAM ]; then
    echo 'nginx-cache: $FETCH_UPSTREAM cannot be empty'
    exit 1
fi

# render upstream into nginx config
sed -i "s|{{ fetch-upstream }}|$FETCH_UPSTREAM|g" /etc/nginx/nginx.conf

# ensure data volume ownership
chown -R nginx:nginx /data/fetch-cache

exec "$@"
