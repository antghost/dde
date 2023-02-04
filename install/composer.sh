#!/bin/bash
[ -f "/usr/local/bin/composer" ] && echo 'Composer Installed' && exit

sudo apt-get update && sudo apt-get install -y curl

sudo curl -o /usr/local/bin/composer -sSL https://getcomposer.org/download/${1:-2.1.14}/composer.phar \
    && sudo chmod ugo+wx /usr/local/bin/composer

if [ -f "/usr/local/bin/composer" ];then
    echo 'Install Composer Done!'
else
    echo 'Error: Install Composer failed.'
fi
