#!/usr/bin/env bash

sed -i "s/RABBITMQ_DEFAULT_USER/$RABBITMQ_DEFAULT_USER/g" /home/taiga/taiga-events/config.json
sed -i "s/RABBITMQ_DEFAULT_PASS/$RABBITMQ_DEFAULT_PASS/g" /home/taiga/taiga-events/config.json
sed -i "s/RABBITMQ_HOST/$RABBITMQ_HOST/g" /home/taiga/taiga-events/config.json
sed -i "s/RABBITMQ_DEFAULT_VHOST/$RABBITMQ_DEFAULT_VHOST/g" /home/taiga/taiga-events/config.json
sed -i "s/TAIGA_SECRET/$TAIGA_SECRET/g" /home/taiga/taiga-events/config.json
sed -i "s/WEBSOCKET_PORT/$WEBSOCKET_PORT/g" /home/taiga/taiga-events/config.json

coffee /home/taiga/taiga-events/index.coffee
