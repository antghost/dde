ARG PHP_VERSION
FROM php:${PHP_VERSION}-fpm

COPY ./php-ext/*.tgz /tmp/

ARG SOURCES_MIRRORS

RUN set -eux; \
    if [ ! -z "$SOURCES_MIRRORS" ];then \
       sed -i "s/deb.debian.org/${SOURCES_MIRRORS}/g" /etc/apt/sources.list; \
    fi;
RUN set -eux; \
    apt-get update && apt-get install -y --no-install-recommends \
        cron \
        gzip \
        zip \
        unzip \
        libpng-dev \
        libjpeg-dev \
        libmcrypt-dev \
        libxml2-dev \
        libzip-dev \
        libxslt-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmagickwand-dev \
RUN set -eux; \
    pecl install /tmp/redis-5.3.7.tgz \
    && pecl install /tmp/mcrypt-1.0.6.tgz \
    && pecl install /tmp/swoole-4.8.13.tgz \
    && pecl install /tmp/imagick-3.7.0.tgz \
    && pecl install /tmp/xdebug-3.1.6.tgz \
    && docker-php-ext-enable redis mcrypt swoole imagick xdebug
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j "$(nproc)" gd zip exif soap intl bcmath xsl sockets pdo_mysql opcache pcntl
RUN apt-get clean && rm -rf /var/lib/apt/lists/* \
    rm -rf /tmp/pear ~/.pearrc && rm -rf /tmp/*.tgz
RUN cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
