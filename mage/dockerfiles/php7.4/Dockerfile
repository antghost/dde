ARG PHP_VERSION
FROM ${PHP_VERSION}

COPY *.tgz /tmp/

ARG SOURCES_MIRRORS
RUN sed -i "s/deb.debian.org/${SOURCES_MIRRORS}/g" /etc/apt/sources.list \
    && apt-get update && apt-get install -y \
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
    && pecl install /tmp/swoole-4.6.1.tgz \
    && docker-php-ext-enable redis mcrypt swoole \
	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j"$(nproc)" gd zip exif soap intl bcmath xsl sockets mysqli pdo_mysql opcache \
    && rm -r /tmp/pear && rm -r /tmp/*.tgz \