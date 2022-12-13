# Magento DDE

## 使用方法

以下操作均需要在 `magento` 目录下执行

### 初始化  

`.env` 中自定义配置  
> 可直接使用默认值

构建镜像  
- 执行 `docker-compose.yml` 中的 `build`
- 构建好的镜像如 `Dockerfile` 无变化，只需构建一次即可
- `Dockerfile` 变化后可重新执行

```bash
sudo docker compose build
```

### 创建和启动 `docker-compose.yml` 中服务

启动所有服务

```bash
sudo docker compose up -d
```

启动指定服务  

```bash
# sudo docker compose up -d <service>
# e.g. 启动 `nginx` 服务
sudo docker compose up -d nginx
```

查看已启动的服务

```bash
sudo docker compose ps
```

关闭所有服务  

```bash
sudo docker compose down
```

### Nginx 配置

server 文件配置路径  

```bash
# 当前目录下
config/nginx/conf.d
```

e.g. 配置 mage.test.com

```bash
cd config/nginx/conf.d
cp conf.sample mage.test.com.conf
# 修改 mage.test.com.conf 中 server_name, $MAGE_ROOT, error_log ...
# 回退到 magento 目录下执行 nginx.sh 脚本
./nginx.sh -s reload
```

### 容器操作

用法  

```bash
sudo docker compose exec --help
```

进入容器  

```bash
# sudo docker compose exec [-u <user>] <service> <bash|sh>
# e.g. 进入service: 'php81' 容器
sudo docker compose exec php81 bash
# e.g. `-u <user>` 指定用户进入容器
sudo docker compose exec -u www-data php81 bash
```

不进入容器直接执行容器中命令

```bash
# sudo docker compose exec <service> <command>
# e.g. 执行 magento 指令
sudo docker compose -u www-data -w /var/www/html php81 bin/magento c:c
```

### 脚本使用

脚本执行提示无权限，使用 `sudo` 执行或添加当前用户到 `docker` 组中  
> 查看 dde/README.md > 允许当前用户访问 Docker CLI  

```bash
# 使用 `sudo` 执行
sudo ./exec.sh
```

exec.sh  
> 进入容器  

```bash
# ./exec.sh [<service>] [<user>]
# 默认用户为：www-data
# 默认容器: php81
# e.g. 进入 PHP7.4 容器
./exec.sh php74
# 容器当前目录为 /var/www/html
# 进入 mage.com 项目中执行 magento 指令
www-data@5a84b77a5eba:~/html$ cd mage.com
www-data@5a84b77a5eba:~/html/mage.com$ bin/magento c:c
```

magento.sh  
> 不进入容器直接执行 `bin/magento` 命令  

- .env 中配置 `MAGENTO_SOURCE`, `MAGENTO_PHP_SERVICE`
- `MAGENTO_SOURCE`: 代码目录
- `MAGENTO_PHP_SERVICE`: docker-compose.yml 中的 PHP `service`

```bash
./magento.sh c:c
./magento.sh s:up
```

nginx.sh
> 不进入容器直接执行 `nginx` 命令  

```bash
./nginx.sh -s reload
```
