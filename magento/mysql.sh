#!/bin/bash
source .env
# docker run -it --network mysql_default --rm mysql:${MYSQL_VERSION} mysql -hsome-mysql -uexample-user -p
docker compose exec mysql mysql -u root -p${MYSQL_ROOT_PASSWORD}
# complete list of available options
# docker run -it --rm mysql:${MYSQL_VERSION} --verbose --help
# docker compose exec db --verbose --help
