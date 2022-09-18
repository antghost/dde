#!/bin/bash
echo 'Starting...';

# 安装composer
./install/composer.sh
# 安装docker
./install/docker.sh

# 创建配置文件
echo 'Configure file init';
if [ ! -f "./mage/config/nginx/nginx.conf" ]; then
    cp ./config/nginx/nginx.conf ./mage/config/nginx/nginx.conf
fi

# 创建'.env'文件
echo 'ENV file init';
for file in * ; do
    if [ -d "$file" -a -f "./$file/.env.sample" -a ! -f "./$file/.env" ]; then
        cp ./$file/.env.sample ./$file/.env;
    fi
done
echo 'Done.'
