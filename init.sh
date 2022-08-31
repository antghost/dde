#!/bin/bash
sudo chmod a+x ./*/*.sh
# Install
sudo ./install/docker.sh
sudo ./install/composer.sh
echo 'Install Done'
# Copy env
if [ ! -f "./mage/.env" ]; then
    sudo cp ./mage/.env.sample ./mage/.env
fi
echo 'Init Env file Done'
