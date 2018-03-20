FROM ubuntu:xenial
LABEL maintainer="jakob@jhaaf.dk"

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y -q  \
        software-properties-common \
        python-software-properties \
    && add-apt-repository ppa:ondrej/php \
    && apt-get update \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
RUN apt-update \
    && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y -q  \
        curl \
        wget \
        php7.2 \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

RUN mkdir -p /run/php/ && \
    touch /run/php/php7.0-fpm.sock
    
CMD ["php-fpm7.0", "--nodaemonize", "--fpm-config", "/etc/php/7.0/fpm/php-fpm.conf"]

WORKDIR /var/www
