FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    net-tools \
    php-fpm \
    php-mysql \
    wget \
    unzip \
    && apt-get clean

# Download and set up WordPress
RUN mkdir -p /var/www/html && \
    wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    mv wordpress/* /var/www/html/ && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html && \
    rm -rf wordpress latest.tar.gz

# Configure PHP-FPM
RUN sed -i "s|;listen.owner = www-data|listen.owner = www-data|g" /etc/php/7.4/fpm/pool.d/www.conf && \
    sed -i "s|;listen.group = www-data|listen.group = www-data|g" /etc/php/7.4/fpm/pool.d/www.conf && \
    sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 9000|g" /etc/php/7.4/fpm/pool.d/www.conf

# Ensure /run/php exists
RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

EXPOSE 9000

WORKDIR /var/www/html

CMD ["php-fpm7.4", "--nodaemonize"]
