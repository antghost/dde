# Docker Development Environment (DDE)

## 概述

OS: Ubuntu

## 安装和初始化

```bash
cd dde
sudo chmod a+x init.sh
sudo ./init.sh
```

## Env环境变量

`.env`文件中配置环境变量

## 容器操作
> 进入`docker-compose.yml`所在目录下执行  

创建和启动服务

```bash
# 启动所有服务
sudo docker compose up -d
# 启动指定服务
sudo docker compose up -d <service>
# 停止和删除所有服务
sudo docker compose down
```

进入容器

```bash
docker compose exec <service> <command>
# e.g. exec redis-cli
docker compose exec redis redis-cli 
```

查看容器日志

```bash
sudo docker compose logs <service>
```