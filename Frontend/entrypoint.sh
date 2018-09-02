#!/usr/bin/env bash

#Set the correct hostname in settings and nginx
sed -i "s/TAIGA_HOSTNAME/$TAIGA_HOSTNAME/g" /home/taiga/taiga-front-dist/dist/conf.json

#Set URLs for GDPR related things
sed -i "s@PRIVACY_URL@$PRIVACY_URL@g" /home/taiga/taiga-front-dist/dist/conf.json
sed -i "s@TERMS_URL@$TERMS_URL@g" /home/taiga/taiga-front-dist/dist/conf.json
sed -i "s@GDPR_URL@$GDPR_URL@g" /home/taiga/taiga-front-dist/dist/conf.json

if [ "$TAIGA_HTTPS" = "true" ]; then
    sed -i "s/http/https/g" /home/taiga/taiga-front-dist/dist/conf.json
    sed -i "s/ws/wss/g" /home/taiga/taiga-front-dist/dist/conf.json
fi

if [ "$TAIGA_ENABLE_REGISTRATION" = "true" ]; then
    sed -i "s/TAIGA_ENABLE_REGISTRATION/true/g" /home/taiga/taiga-front-dist/dist/conf.json
else
    sed -i "s/TAIGA_ENABLE_REGISTRATION/false/g" /home/taiga/taiga-front-dist/dist/conf.json
fi

if [ "$TAIGA_INSTALL_SLACK" = "true" ]; then
    mkdir -p /home/taiga/taiga-front-dist/dist/plugins
    git clone https://github.com/taigaio/taiga-contrib-slack.git /tmp/taiga-contrib-slack
    mv /tmp/taiga-contrib-slack/front/dist /home/taiga/taiga-front-dist/dist/plugins/slack

    sed -i "s@INSTALLED_PLUGINS@\"/plugins/slack/slack.json\"@g" /home/taiga/taiga-front-dist/dist/conf.json

    printf "\nINSTALLED SLACK PLUGIN\n"
else
    sed -i "s/INSTALLED_PLUGINS//g" /home/taiga/taiga-front-dist/dist/conf.json
fi

printf "\nSTART NGINX\n"
nginx -g 'daemon off;'