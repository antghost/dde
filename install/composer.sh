#!/bin/bash
[ -f "/usr/local/bin/composer" ] && echo 'Composer Installed' && exit
version=${1:-2.1.14}
wget https://getcomposer.org/download/$version/composer.phar
sudo mv composer.phar /usr/local/bin/composer
sudo chmod a+x /usr/local/bin/composer
echo 'Install Composer Done!'
