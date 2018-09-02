#!/usr/bin/env bash

sed -i "s/POSTGRES_DB/$POSTGRES_DB/g" /home/taiga/taiga-back/settings/local.py
sed -i "s/POSTGRES_HOST/$POSTGRES_HOST/g" /home/taiga/taiga-back/settings/local.py
sed -i "s/POSTGRES_USER/$POSTGRES_USER/g" /home/taiga/taiga-back/settings/local.py
sed -i "s/POSTGRES_PASSWORD/$POSTGRES_PASSWORD/g" /home/taiga/taiga-back/settings/local.py

sed -i "s/TAIGA_HOSTNAME/$TAIGA_HOSTNAME/g" /home/taiga/taiga-back/settings/local.py

sed -i "s/TAIGA_SECRET/$TAIGA_SECRET/g" /home/taiga/taiga-back/settings/local.py

if [ "$TAIGA_ENABLE_REGISTRATION" = "true" ]; then
    sed -i "s/TAIGA_ENABLE_REGISTRATION/True/g" /home/taiga/taiga-back/settings/local.py
else
    sed -i "s/TAIGA_ENABLE_REGISTRATION/False/g" /home/taiga/taiga-back/settings/local.py
fi

if [ "$TAIGA_HTTPS" = "true" ]; then
    sed -i "s/http/https/g" /home/taiga/taiga-back/settings/local.py
fi

sed -i "s/RABBITMQ_DEFAULT_USER/$RABBITMQ_DEFAULT_USER/g" /home/taiga/taiga-back/settings/local.py
sed -i "s/RABBITMQ_DEFAULT_PASS/$RABBITMQ_DEFAULT_PASS/g" /home/taiga/taiga-back/settings/local.py
sed -i "s/RABBITMQ_HOST/$RABBITMQ_HOST/g" /home/taiga/taiga-back/settings/local.py
sed -i "s/RABBITMQ_DEFAULT_VHOST/$RABBITMQ_DEFAULT_VHOST/g" /home/taiga/taiga-back/settings/local.py

#sed /home/taiga/taiga-back/settings/local.py
source /usr/local/bin/virtualenvwrapper.sh
mkvirtualenv taiga

pip install --no-cache-dir -r requirements.txt

python manage.py migrate --noinput
python manage.py loaddata initial_user
python manage.py loaddata initial_project_templates
python manage.py compilemessages
python manage.py collectstatic --noinput

if [ "$TAIGA_INSTALL_SLACK" = "true" ]; then
    pip install taiga-contrib-slack
    python manage.py migrate taiga_contrib_slack
    echo -e "\nINSTALLED_APPS += [\"taiga_contrib_slack\"]\n" >> /home/taiga/taiga-back/settings/local.py
fi

printf "\nSTART AND RELOAD NGINX\n"
sudo nginx && sudo nginx -s reload

printf "\nSTART SERVER ON PORT 8000\n"
python /home/taiga/taiga-back/manage.py runserver 0.0.0.0:8000