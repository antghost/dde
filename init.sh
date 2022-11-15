#!/bin/bash
echo 'Starting...';

# 安装composer
./install/composer.sh
# 安装docker
./install/docker.sh

# 创建配置文件
## Nginx
echo 'Configure file init';
if [ ! -f "./mage/config/nginx/nginx.conf" ]; then
    mkdir -p ./mage/config/nginx
    cp ./config/nginx/nginx.conf ./mage/config/nginx/nginx.conf
fi
## PHP
if [ ! -f "./mage/config/php/php.ini" ]; then
    mkdir -p ./mage/config/php
    cp ./config/php/php.ini ./mage/config/php/php.ini
fi
## es
if [ ! -f "./mage/config/es/elasticsearch.yml" ]; then
    mkdir -p ./mage/config/es
    cp ./config/es/elasticsearch.yml ./mage/config/es/elasticsearch.yml
fi
## Redis
if [ ! -f "./mage/config/redis/redis.conf" ]; then
    mkdir -p ./mage/config/redis
    cp ./config/redis/redis.conf ./mage/config/redis/redis.conf
fi
if [ ! -f "./redis/redis.conf" ]; then
    cp ./config/redis/redis.conf ./redis/redis.conf
fi

# 创建'.env'文件
echo 'ENV file init';
for file in * ; do
    if [ -d "$file" -a -f "./$file/.env.sample" -a ! -f "./$file/.env" ]; then
        cp ./$file/.env.sample ./$file/.env;
    fi
done
echo 'Done.'
