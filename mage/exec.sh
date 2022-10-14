#!/bin/bash
docker compose exec -u ${2:-www-data} ${1:-php81} ${3:-bash}
