#!/usr/bin/env bash

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
python /home/taiga/taiga-back/manage.py runserver 0.0.0.0:800