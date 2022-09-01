# Magento DDE

## Usage

### Init

Set environment variables
> .env

Build services  

```bash
sudo docker composer build
```

### Create and start services

all services

```bash
sudo docker compose up -d
```

'app' service

```bash
sudo docker compose up -d app
```

### Run a command in a running container

```bash
sudo docker compose exec <server> <command>
# e.g.
sudo docker compose exec app bin/bash
```
