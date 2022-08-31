# 该容器用完即焚
docker run -it -u www-data --rm \
    -v /usr/local/bin/composer:/usr/local/bin/composer \
    -v /home/www/mage2.4:/var/www/html \
    -v ~/.composer:/var/www/.composer:cached \
    php/mage:7.4.15-fpm bash