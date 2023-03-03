# Gitlab

## Offline Docs

```bash
docker run -it -d -p 4011:4000 registry.gitlab.com/gitlab-org/gitlab-docs:11.3
docker run -it -d -p 4015:4000 registry.gitlab.com/gitlab-org/gitlab-docs:15.8
```

## Install

doc  
> https://docs.gitlab.com/ee/install/docker.html  

Root password
> https://docs.gitlab.com/ee/security/reset_user_password.html#reset-your-root-password  

either via `GITLAB_ROOT_PASSWORD` environment variable or via `gitlab_rails['initial_root_password']` setting in `gitlab.rb`

### 15.8 版本

```bash
# First reconfigure
# NOTE:The password file will be automatically deleted in the first reconfigure run after 24 hours.
docker exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password
```

### 11.1 版本
安装后首次打开网页会要求修改 root 密码


### 修改密码  

```bash
# use rake
gitlab-rake "gitlab:password:reset[root]"

# use gitlab console
gitlab-rails console -e production
user = User.where(id: 1).first
user.password = 'your secret'
user.password_confirmation = 'your secret'
user.save
exit
```

## Gitlab container

Container status:   

health: starting  `启动中`  
unhealth  `启动失败`  
healthy  `启动成功`  

## Gitlab tool

gitlab-ctl <parameter>

parameter:
start                `启动所有服务`  
stop                `关闭所有服务`  
restart            `重启所有服务`  
status             `查看所有服务状态`  
tail               `查看日志信息`  
service-list        `列举所有启动服务`  
graceful-kill      `平稳停止一个服务`  
reconfigure       `修改配置文件后需要重新加载`  
show-config        `查看所有服务配置文件信息`  

```bash
docker compose exec gitlab bash
gitlab-ctl show-config
```

## Backup

路径： `/var/opt/gitlab/backups`
> 对应 Docker 挂载本地路径: `$GITLAB_HOME/data/backups/`  

备份后文件是一个 tar 包，例如：
1677555454_2023_02_28_15.8.3-ee_gitlab_backup.tar  

Omnibus package

```bash
sudo gitlab-rake gitlab:backup:create
```

Docker

```bash
# Docker compose
docker compose exec gitlab gitlab-rake gitlab:backup:create
# Docker engine
#docker exec -t gitlab gitlab-rake gitlab:backup:create
```

### 计划任务自动备份

NOTE: Note:
The following cron jobs do not backup your GitLab configuration files
or SSH host keys.

备份保留时间，该配置在 docker .env 中配置

```bash
## Limit backup lifetime to 7 days - 604800 seconds
gitlab_rails['backup_keep_time'] = 604800
```

crontab

```bash
# Omnibus GitLab packages
0 2 * * * /opt/gitlab/bin/gitlab-rake gitlab:backup:create CRON=1
# Docker
0 2 * * * docker exec -t gitlab gitlab-rake gitlab:backup:create CRON=1
```

## Restore

路径： `/var/opt/gitlab/backups`  
> 对应 Docker 挂载本地路径: `$GITLAB_HOME/data/backups/`  

修改权限

```bash
docker compose exec gitlab chown git.git /var/opt/gitlab/backups/*.tar
# -rw-rw-rw- 1 git root 1136640 Feb 28 03:37 1677555454_2023_02_28_15.8.3-ee_gitlab_backup.tar
```

文件恢复：
- /etc/gitlab/gitlab-secrets.json 
  > 对应 Docker 挂载本地路径: `$GITLAB_HOME/config/gitlab-secrets.json`

当存在多个备份时需要指定备份文件的 timestamp

e.g. 备份文件名： `1677650771_2023_03_01_15.8.3-ee_gitlab_backup.tar`, 文件 timestamp为： `1677650771_2023_03_01_15.8.3-ee`

使用 `BACKUP` 参数

```bash
docker compose exec gitlab gitlab-rake gitlab:backup:restore BACKUP=1677650771_2023_03_01_15.8.3-ee
```

e.g.

```bash
# Docker compose
docker compose exec gitlab gitlab-rake gitlab:backup:restore
# Docker engine
#docker exec -it gitlab gitlab-rake gitlab:backup:restore

Unpacking backup ... done
Before restoring the database, we will remove all existing
tables to avoid future upgrade problems. Be aware that if you have
custom tables in the GitLab database these tables and all data will be
removed.

Do you want to continue (yes/no)? yes


This task will now rebuild the authorized_keys file.
You will lose any data stored in the authorized_keys file.
Do you want to continue (yes/no)? yes

# Restart container
# Docker compose
docker compose restart gitlab
# Docker engine
#docker restart gitlab
```

## Upgrade

升级路径  
> https://gitlab-com.gitlab.io/support/toolbox/upgrade-path/  

#### 非主版本升级

**Docker 方式**  
> 备份后，直接使用主版本对应的最新版本镜像运行即可  

- 关闭容器 `docker compose down` 
- 修改 .env 中 GITLAB_IMAGE=gitlab/gitlab-ee:<latest version>-ee.0  
- `docker compose up -d`, 使用新镜首次运行容器 gitlab 会自动升级  

#### 主版本升级

按升级路径逐个版本升级  
