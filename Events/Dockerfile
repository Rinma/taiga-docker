FROM node:8
MAINTAINER Marvin Dalheimer <me@marvin-dalheimer.de>

RUN npm install -g coffeescript

RUN useradd -ms /bin/bash taiga && \
    usermod -aG sudo taiga && \
    mkdir -p /home/taiga/logs

RUN git clone https://github.com/taigaio/taiga-events.git /home/taiga/taiga-events && \
    cd /home/taiga/taiga-events && \
    npm install

ADD config.json /home/taiga/taiga-events/config.json

WORKDIR /home/taiga/taiga-events
RUN chown -R taiga:taiga /home/taiga

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER taiga
CMD /entrypoint.sh
