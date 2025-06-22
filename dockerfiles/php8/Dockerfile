ARG PHP_VERSION
FROM php:${PHP_VERSION:-8.4}-fpm

ARG SOURCES_MIRRORS

RUN set -eux; \
    if [ ! -z "$SOURCES_MIRRORS" ];then \
      sed -i "s/deb.debian.org/${SOURCES_MIRRORS}/g" /etc/apt/sources.list.d/debian.sources; \
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
    pecl install https://pecl.php.net/get/redis-6.2.0.tgz \
    && pecl install https://pecl.php.net/get/mcrypt-1.0.7.tgz \
    && pecl install https://pecl.php.net/get/swoole-5.1.7.tgz \
    && pecl install https://pecl.php.net/get/imagick-3.8.0.tgz \
    && pecl install https://pecl.php.net/get/ssh2-1.4.1.tgz \
    && pecl install https://pecl.php.net/get/xdebug-3.4.3.tgz \
    && docker-php-ext-enable redis mcrypt swoole imagick ssh2 xdebug
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j "$(nproc)" gd zip exif soap intl bcmath xsl sockets pdo_mysql opcache pcntl
RUN apt-get clean && rm -rf /var/lib/apt/lists/* \
    rm -rf /tmp/pear ~/.pearrc && rm -rf /tmp/*.tgz
RUN cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
