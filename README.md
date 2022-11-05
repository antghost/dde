# Docker Development Environment (DDE)

## 概述

基于 Docker 搭建的开发环境  

OS: Ubuntu

## 安装

### WSL安装（可选）

Windows 中以管理员身份运行命令提示符(CMD)  

```bash
# 查看可安装的分发版本
wsl -l -o
# wsl --install -d <NAME>
# e.g. 安装 Ubuntu-20.04
wsl --install -d Ubuntu-20.04
```

### 初始化DDE  

```bash
cd dde
sudo ./init.sh
sudo service docker start
```

允许当前用户访问 Docker CLI，不必使用 `sudo`  

```bash
sudo usermod -aG docker $USER
```

初始化完成后即可进入到各服务目录下启动容器使用  

## Docker服务操作

```bash
# 启动
sudo service docker start
# 停止
sudo service docker stop
# 重启
sudo service docker restart
# 日志
sudo tail -f /var/log/docker.log
```

## Env环境变量

`.env` 文件中配置环境变量

## 容器操作
> 进入 `docker-compose.yml` 所在目录下执行  

创建和启动服务

```bash
# 启动所有服务
sudo docker compose up -d
# 启动指定服务
sudo docker compose up -d <service>
# 查看已启动的服务
sudo docker compose ps
# 停止和删除所有服务
sudo docker compose down
```

进入容器

```bash
# sudo docker compose exec <service> <command>
# e.g. exec redis-cli
sudo docker compose exec redis redis-cli 
```

查看容器日志

```bash
# sudo docker compose logs <service>
# e.g. redis logs
sudo docker compose logs redis
```

启动一个用完即焚的容器  

```bash
sudo docker run --rm -it -u www-data php:7.4.27-fpm bash
```
