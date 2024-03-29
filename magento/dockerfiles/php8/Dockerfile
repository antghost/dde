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
        zip \
        unzip \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        libmcrypt-dev \
        libxml2-dev \
        libzip-dev \
        libxslt-dev \
        libmagickwand-dev \
        libssh2-1-dev
RUN set -eux;\
    pecl install /tmp/redis-5.3.7.tgz \
    && pecl install /tmp/mcrypt-1.0.6.tgz \
    && pecl install /tmp/swoole-5.0.3.tgz \
    && pecl install /tmp/imagick-3.7.0.tgz \
    && pecl install /tmp/ssh2-1.4.tgz \
    && pecl install /tmp/xdebug-3.2.2.tgz \
    && docker-php-ext-enable redis mcrypt swoole imagick ssh2 xdebug
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j "$(nproc)" gd zip exif soap intl bcmath xsl sockets pdo_mysql opcache pcntl
RUN apt-get clean && rm -rf /var/lib/apt/lists/* \
    rm -rf /tmp/pear ~/.pearrc && rm -rf /tmp/*.tgz
RUN cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
