FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    net-tools \
    php-fpm \
    php-mysql \
    wget \
    unzip \
    && apt-get clean

ENV WORDPRESS_PATH="/var/www/html"

RUN mkdir -p $WORDPRESS_PATH && \
    wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    mv wordpress/* "$WORDPRESS_PATH/" && \
    rm -rf wordpress latest.tar.gz


RUN sed -i "s|;listen.owner = www-data|listen.owner = www-data|g" /etc/php/7.4/fpm/pool.d/www.conf && \
    sed -i "s|;listen.group = www-data|listen.group = www-data|g" /etc/php/7.4/fpm/pool.d/www.conf && \
    sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 9000|g" /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

EXPOSE 9000

WORKDIR $WORDPRESS_PATH

CMD ["php-fpm7.4", "--nodaemonize"]
