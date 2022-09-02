#!/bin/bash
# 该容器用完即焚
source .env
docker run -it -u www-data --rm \
    -v /usr/local/bin/composer:/usr/local/bin/composer \
    -v $1:/var/www/html \
    -v ${COMPOSER_HOME}:/var/www/.composer:cached \
    ${PHP_MAGE_IMAGE} bash