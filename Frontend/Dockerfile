FROM nginx:latest
MAINTAINER Marvin Dalheimer <me@marvin-dalheimer.de>

RUN apt-get update && \
    apt-get install -y git && \
    apt-get clean && \
    rm -rf /var/apt/cache

RUN useradd -ms /bin/bash taiga && \
    usermod -aG sudo taiga && \
    mkdir -p /home/taiga/logs

RUN git clone https://github.com/taigaio/taiga-front-dist.git /home/taiga/taiga-front-dist && \
    cd /home/taiga/taiga-front-dist && \
    git checkout stable

ADD conf.json /home/taiga/taiga-front-dist/dist/conf.json
ADD front.nginx /etc/nginx/conf.d/front.conf

WORKDIR /home/taiga/taiga-front-dist
RUN chown -R taiga:taiga /home/taiga

CMD nginx -g 'daemon off;'