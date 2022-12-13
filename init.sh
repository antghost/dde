#!/bin/bash
echo 'Starting...';

# 安装composer
./install/composer.sh
# 安装docker
./install/docker.sh

# 创建配置文件
## Nginx
mage_config_dir=./magento/config;
echo 'Configure file init';
if [ ! -f "$mage_config_dir/nginx/nginx.conf" ]; then
    mkdir -p $mage_config_dir/nginx
    cp ./config/nginx/nginx.conf $mage_config_dir/nginx/nginx.conf
fi
## PHP
if [ ! -f "$mage_config_dir/php/php.ini" ]; then
    mkdir -p $mage_config_dir/php
    cp ./config/php/php.ini $mage_config_dir/php/php.ini
fi
## es
if [ ! -f "$mage_config_dir/es/elasticsearch.yml" ]; then
    mkdir -p $mage_config_dir/es
    cp ./config/es/elasticsearch.yml $mage_config_dir/es/elasticsearch.yml
fi
## Redis
if [ ! -f "$mage_config_dir/redis/redis.conf" ]; then
    mkdir -p $mage_config_dir/redis
    cp ./config/redis/redis.conf $mage_config_dir/redis/redis.conf
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
