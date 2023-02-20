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
if [ ! -d "$mage_config_dir/php" ]; then
    mkdir -p $mage_config_dir/php
fi
cp -n ./config/php/* $mage_config_dir/php
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

# 创建 docker-compose 文件
echo 'docker-compose && env file init';
for file in * ; do
    if [ -d "$file" -a -f "./$file/.env.example" -a ! -f "./$file/.env" ]; then
        cp ./$file/.env.example ./$file/.env;
    fi
    if [ -d "$file" -a -f "./$file/docker-compose.example.yml" -a ! -f "./$file/docker-compose.yml" ]; then
        cp ./$file/docker-compose.example.yml ./$file/docker-compose.yml;
    fi
done
echo 'Done.'
