FROM tomcat:8

RUN set -ex; \
    \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    exuberant-ctags; \
    rm -rf /var/lib/apt/lists/*;

RUN set -ex; \
    \
    wget https://github.com/oracle/opengrok/releases/download/1.1-rc21/opengrok-1.1-rc21.tar.gz -O /tmp/opengrok-1.1-rc21.tar.gz; \
    tar -xvzf /tmp/opengrok-1.1-rc21.tar.gz  -C /; \
    rm /tmp/opengrok-1.1-rc21.tar.gz; \
    mkdir -p /var/opengrok/src; \ 
    mkdir -p /var/opengrok/data; \
    mkdir -p /var/opengrok/etc; \
    ln -s /var/opengrok/src /src; \
    ln -s /var/opengrok/data /data;

ENV OPENGROK_TOMCAT_BASE /usr/local/tomcat

ENV PATH="/opengrok-1.1-rc21/bin:$PATH"

RUN OpenGrok deploy;

COPY docker-entrypoint.sh /usr/local/bin/

RUN set -ex; \
    chmod +x /usr/local/bin/docker-entrypoint.sh;

ENTRYPOINT [ "docker-entrypoint.sh" ]

EXPOSE 8080

CMD ["catalina.sh", "run"]
