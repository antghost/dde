ARG PHP_VERSION
FROM php:${PHP_VERSION}-fpm

COPY *.tgz /tmp/

ARG SOURCES_MIRRORS
RUN sed -i "s/deb.debian.org/${SOURCES_MIRRORS}/g" /etc/apt/sources.list \
    && apt-get update && apt-get install -y --no-install-recommends \
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
    && apt-get clean \
    && pecl install /tmp/redis-5.1.1.tgz \
    && pecl install /tmp/mcrypt-1.0.3.tgz \
    && docker-php-ext-enable redis mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir --with-jpeg-dir \
    && docker-php-ext-install -j"$(nproc)" gd zip exif soap intl bcmath xsl sockets mysqli pdo_mysql opcache \
    && rm -r /tmp/pear && rm -r /tmp/*.tgz
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
