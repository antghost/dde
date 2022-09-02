#!/bin/bash
sudo chmod a+x ./*/*.sh
# Install
./install/composer.sh
./install/docker.sh
echo 'Install Done'
# Copy configure file
# echo 'Configure file init';
# Copy env file
if [ ! -f "./mage/.env" ]; then
    sudo cp ./mage/.env.sample ./mage/.env
fi;
if [ ! -f "./portainer/.env" ]; then
    sudo cp ./portainer/.env.sample ./portainer/.env
fi;
if [ ! -f "./mysql/.env" ]; then
    sudo cp ./mysql/.env.sample ./mysql/.env
fi;
if [ ! -f "./redis/.env" ]; then
    sudo cp ./redis/.env.sample ./redis/.env
fi;
if [ ! -f "./rabbitmq/.env" ]; then
    sudo cp ./rabbitmq/.env.sample ./rabbitmq/.env
fi;
echo 'ENV file init';
