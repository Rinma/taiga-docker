FROM python:3.6-stretch
MAINTAINER Marvin Dalheimer <me@marvin-dalheimer.de>

ENV VIRTUAL_ENV /home/taiga/.virtualenvs
ENV VIRTUALENVWRAPPER_PYTHON /usr/local/bin/python

RUN apt-get update && \
    apt-get install -y build-essential binutils-doc autoconf flex bison libjpeg-dev \
    libfreetype6-dev zlib1g-dev libzmq3-dev libgdbm-dev libncurses5-dev \
    automake libtool libffi-dev curl git tmux gettext circus sudo \
    python3 python3-pip python-dev python3-dev python-pip \
    libxml2 libssl-dev libffi-dev bash nginx \
    libxml2-dev libxslt-dev libssl-dev libffi-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/cache

RUN useradd -ms /bin/bash taiga && \
    usermod -aG sudo taiga && \
    mkdir -p /home/taiga/logs

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN git clone https://github.com/taigaio/taiga-back.git /home/taiga/taiga-back && \
    cd /home/taiga/taiga-back && \
    git checkout stable

RUN pip install virtualenvwrapper

WORKDIR /home/taiga/taiga-back
RUN chown -R taiga:taiga /home/taiga

ADD backend.nginx /etc/nginx/conf.d/backend.conf
ADD local.py /home/taiga/taiga-back/settings/local.py
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8000

VOLUME /home/taiga/taiga-back/media
VOLUME /home/taiga/taiga-back/static

CMD /entrypoint.sh