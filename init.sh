#!/bin/bash
echo 'Starting...';

mkdir -p ./data ./logs && chmod 777 ./data ./logs
# data
mkdir -p ./data/magento/es && sudo chown 1000:0 ./data/magento/es && sudo chmod g+rwx ./data/magento/es
# logs
mkdir -p ./logs/magento/{php72,php74,php81,php82} && chmod 777 ./logs/magento/php*

mage_config_dir=./magento/config;
echo 'Configure file init';
## PHP
mkdir -p $mage_config_dir/php && cp -n ./config/php/* $mage_config_dir/php
## Redis
mkdir -p $mage_config_dir/redis && cp -n ./config/redis/*.conf $mage_config_dir/redis/
cp -n ./config/redis/*.conf ./redis/

# 创建 docker-compose 文件
echo 'docker-compose && env file init';
for file in * ; do
    if [ -d "$file" -a -f "./$file/env.example" -a ! -f "./$file/.env" ]; then
        cp ./$file/env.example ./$file/.env;
    fi
    if [ -d "$file" -a -f "./$file/docker-compose.example.yml" -a ! -f "./$file/docker-compose.yml" ]; then
        cp ./$file/docker-compose.example.yml ./$file/docker-compose.yml;
    fi
done

network_dde=`docker network list | grep dde | wc -l`
if [ $network_dde == 0 ]; then
    docker network create dde
fi

echo 'Done.'
