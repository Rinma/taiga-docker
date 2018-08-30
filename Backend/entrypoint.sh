#!/usr/bin/env bash

sed -i "s/POSTGRES_DB/$POSTGRES_DB/g" /home/taiga/taiga-back/settings/local.py
sed -i "s/POSTGRES_HOST/$POSTGRES_HOST/g" /home/taiga/taiga-back/settings/local.py
sed -i "s/POSTGRES_USER/$POSTGRES_USER/g" /home/taiga/taiga-back/settings/local.py
sed -i "s/POSTGRES_PASSWORD/$POSTGRES_PASSWORD/g" /home/taiga/taiga-back/settings/local.py

sed -i "s/TAIGA_HOSTNAME/$TAIGA_HOSTNAME/g" /home/taiga/taiga-back/settings/local.py
sed -i "s/TAIGA_SECRET/$TAIGA_SECRET/g" /home/taiga/taiga-back/settings/local.py

sed -i "s/RABBITMQ_DEFAULT_USER/$RABBITMQ_DEFAULT_USER/g" /home/taiga/taiga-back/settings/local.py
sed -i "s/RABBITMQ_DEFAULT_PASS/$RABBITMQ_DEFAULT_PASS/g" /home/taiga/taiga-back/settings/local.py
sed -i "s/RABBITMQ_HOST/$RABBITMQ_HOST/g" /home/taiga/taiga-back/settings/local.py
sed -i "s/RABBITMQ_DEFAULT_VHOST/$RABBITMQ_DEFAULT_VHOST/g" /home/taiga/taiga-back/settings/local.py

sed -i "s/TAIGA_HOSTNAME/$TAIGA_HOSTNAME/g" /etc/nginx/conf.d/backend.conf

#sed /home/taiga/taiga-back/settings/local.py
source /usr/local/bin/virtualenvwrapper.sh
mkvirtualenv taiga

pip install --no-cache-dir -r requirements.txt

python manage.py migrate --noinput && \
python manage.py loaddata initial_user && \
python manage.py loaddata initial_project_templates && \
python manage.py compilemessages && \
python manage.py collectstatic --noinput

sudo nginx && sudo nginx -s reload
python /home/taiga/taiga-back/manage.py runserver 0.0.0.0:8000