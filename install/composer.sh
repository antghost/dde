#!/bin/bash
[ -f "/usr/local/bin/composer" ] && echo 'Composer Installed' && exit
sudo curl -o /usr/local/bin/composer -sSL https://getcomposer.org/download/${1:-2.1.14}/composer.phar && sudo chmod ugo+wx /usr/local/bin/composer
echo 'Install Composer Done!'
