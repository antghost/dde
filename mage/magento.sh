#!/bin/bash
source .env
docker compose exec -u www-data \
    -w $MAGENTO_SOURCE \
    $MAGENTO_PHP_SERVICE bin/magento "$@"