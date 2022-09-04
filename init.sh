#!/bin/bash
sudo chmod a+x ./*/*.sh

# 安装composer
./install/composer.sh
# 安装docker
./install/docker.sh
echo 'Install Done'

# 创建配置文件
if [ ! -f "./mage/config/nginx/nginx.conf" ]; then
    cp ./config/nginx/nginx.conf ./mage/config/nginx/nginx.conf
fi
echo 'Configure file init';

# 创建'.env'文件
for file in * ; do
    if [ -d "$file" -a -f "./$file/.env.sample" -a ! -f "./$file/.env" ]; then
        cp ./$file/.env.sample ./$file/.env;
    fi
done
echo 'ENV file init';
