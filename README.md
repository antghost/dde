# Docker Development Environment (DDE)

## Summary

OS: Ubuntu

## Init

```bash
cd dde
sudo chmod a+x init.sh
sudo ./init.sh
```

## Env Setting

## Usage

Start Service

```bash
# 启动所有服务
sudo docker compose up -d
# 启动指定服务
sudo docker compose up -d <service>
```

exec docker container

```bash
# 进入docker-compose.yml所在目录下执行
docker compose exec <container name> <command>
# e.g. exec redis-cli
docker compose exec redis redis-cli 
```