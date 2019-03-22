#!/bin/bash

# read fetch-upstream input
if [ -z $1 ]; then
    echo 'nginx-cache: fetch-upstream not specified'
    exit 1
fi

# render upstream into nginx config
sed -i "s|{{ fetch-upstream }}|$1|g" /etc/nginx/nginx.conf

# ensure data volume ownership
chown -R nginx:nginx /data/fetch-cache

# start nginx
exec nginx -g 'daemon off;'
