# Magento DDE

## 使用方法

以下操作均需要在`mage`目录下执行

### 初始化  

`.env`中自定义配置  
> 可直接使用默认值

构建镜像  
- 执行`docker-compose.yml`中的`build`
- 构建好的镜像如`Dockerfile`无变化，只需构建一次即可
- `Dockerfile`变化后可重新执行

```bash
sudo docker composer build
```

### 创建和启动`docker-compose.yml`中服务

启动所有服务

```bash
sudo docker compose up -d
```

启动指定服务  

```bash
sudo docker compose up -d <service>
# e.g. 启动`app`服务
sudo docker compose up -d app
```

关闭所有服务  

```bash
sudo docker compose down
```

### 容器操作

用法  

```bash
sudo docker compose exec --help
```

进入容器  

```bash
sudo docker compose exec <service> bash|sh
# e.g. 进入service: 'php81' 容器
sudo docker compose exec php81 bash
# e.g. 指定用户进入容器
sudo docker compose exec -u www-data php81 bash
```

不进入容器直接执行容器中命令

```bash
sudo docker compose exec <service> <command>
# e.g. 执行magento指令
sudo docker compose -u www-data -w /var/www/html php81 bin/magento c:c
```

### 脚本使用

exec.sh  
> 进入容器  

```bash
# 默认用户为：www-data
./exec.sh <service> [<user>]
```

magento.sh  

- .env 中配置 `MAGENTO_SOURCE`, `MAGENTO_PHP_SERVICE`
- `MAGENTO_SOURCE`: 代码目录
- `MAGENTO_PHP_SERVICE`: docker-compose.yml中的PHP`service`

```bash
./magento.sh c:c
./magento.sh s:up
```

nginx.sh

```bash
./nginx.sh -s reload
```
