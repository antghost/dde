# Docker Development Environment (DDE)

## 概述

基于 Docker 搭建的开发环境  

## 安装

### Linux

安装 docker  

```bash
curl -fsSL https://get.docker.com | sh
```

### WSL

安装 WSL  
- Windows 中以管理员身份运行命令提示符(CMD)  

```bash
# 查看可安装的分发版本
wsl -l -o
# wsl --install -d <NAME>
# e.g. 安装 Ubuntu-22.04
wsl --install -d Ubuntu-22.04
```

安装 docker

```bash
# 在 wsl 中
cd dde
./install/docker.sh
```

### 不需要 `sudo` 执行 `docker` 命令

将当前用户添加到 `docker` 组中  

- ubutntu  

```bash
sudo usermod -aG docker $USER
newgrp docker
```

- centos  

```bash
sudo gpasswd -a $USER docker
newgrp docker
```

### 初始化 DDE  

```bash
cd dde
./init.sh
```

## Env 环境变量

`.env` 文件中配置环境变量  
> 可直接选择已配置的默认值  

## Docker 服务操作

```bash
# 启动
sudo systemctl start docker
# 停止
sudo systemctl stop docker
# 重启
sudo systemctl restart docker
# 日志
sudo tail -f /var/log/docker.log
```

## 容器操作
> 进入 `docker-compose.yml` 所在目录下执行  

创建和启动服务

```bash
# 启动所有服务
docker compose up -d
# 启动指定服务
docker compose up -d <service>
# 查看已启动的服务
docker compose ps
# 停止和删除所有服务
docker compose down
```

进入容器

```bash
# docker compose exec <service> <command>
# e.g. exec redis-cli
docker compose exec redis redis-cli 
```

查看容器日志

- docker logs  

```bash
# docker logs <container>
# e.g. container name 'mysql8' logs
docker logs mysql8
```

- docker compose logs  

```bash
# docker compose logs <service>
# e.g. service 'redis' logs
docker compose logs redis
```

启动一个用完即焚的容器  

```bash
docker run --rm -it -u www-data php:7.4-fpm bash
```

## HTTP

创建个人域名 SSL 证书

```bash
# Ubuntu
# 将域名 woo.wp.test 替换成你的
openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes \
  -keyout woo.wp.test.key -out woo.wp.test.crt -subj "/CN=woo.wp.test" \
  -addext "subjectAltName=DNS:woo.wp.test,IP:127.0.0.1"
```
