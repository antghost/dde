#!/bin/bash
source .env
# sudo docker run -it --network mysql_default --rm mysql:${MYSQL_VERSION} mysql -hsome-mysql -uexample-user -p
sudo docker compose exec db mysql -u root -p${MYSQL_ROOT_PASSWORD}
# complete list of available options
# sudo docker run -it --rm mysql:${MYSQL_VERSION} --verbose --help
# sudo docker compose exec db --verbose --help
