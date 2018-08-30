#!/usr/bin/env bash

sed -i "s/TAIGA_HOSTNAME/$TAIGA_HOSTNAME/g" /home/taiga/taiga-front-dist/dist/conf.json
sed -i "s/PRIVACY_URL/$PRIVACY_URL/g" /home/taiga/taiga-front-dist/dist/conf.json
sed -i "s/TERMS_URL/$TERMS_URL/g" /home/taiga/taiga-front-dist/dist/conf.json
sed -i "s/GDPR_URL/$GDPR_URL/g" /home/taiga/taiga-front-dist/dist/conf.json

sed -i "s/TAIGA_HOSTNAME/$TAIGA_HOSTNAME/g" /etc/nginx/conf.d/front.conf

nginx -g 'daemon off;'
