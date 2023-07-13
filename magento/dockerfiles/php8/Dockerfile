ARG PHP_VERSION
FROM php:${PHP_VERSION}-fpm

COPY ./php-ext/*.tgz /tmp/

ARG SOURCES_MIRRORS

RUN if [ ! -z "$SOURCES_MIRRORS" ];then \
    lsb_version="$(. /etc/os-release && echo "$VERSION_ID")"; \
      if [ $lsb_version -lt 12 ];then \
        sed -i "s/deb.debian.org/${SOURCES_MIRRORS}/g" /etc/apt/sources.list; \
      else \
        sed -i "s/deb.debian.org/${SOURCES_MIRRORS}/g" /etc/apt/sources.list.d/debian.sources; \
      fi; \
    fi;

RUN apt-get update && apt-get install -y --no-install-recommends \
        cron \
        gzip \
        libpng-dev \
        libjpeg-dev \
        libmcrypt-dev \
        libxml2-dev \
        libzip-dev \
        libxslt-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        zip \
        imagemagick \
        libmagickwand-dev \
    && apt-get clean \
    && pecl install /tmp/redis-5.3.7.tgz \
    && pecl install /tmp/mcrypt-1.0.6.tgz \
    && pecl install /tmp/swoole-5.0.3.tgz \
    && pecl install /tmp/imagick-3.7.0.tgz \
    && pecl install /tmp/xdebug-3.2.1.tgz \
    && docker-php-ext-enable redis mcrypt swoole imagick xdebug \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j"$(nproc)" gd zip exif soap intl bcmath xsl sockets mysqli pdo_mysql opcache pcntl \
    && rm -r /tmp/pear && rm -r /tmp/*.tgz
RUN cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
