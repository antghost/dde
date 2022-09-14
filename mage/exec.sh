#!/bin/bash
docker compose exec -u ${2:-www-data} $1 ${3:-bash}
