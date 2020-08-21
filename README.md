# 引用了 ifui/baota 的配置
非常棒的宝塔配置脚本。具体请参考 [ifui/baota](https://github.com/ifui/baota)

# 修改项目

- 将app及app_backup合并，并更名docker，防止混淆。

- env文件增加了xdebug的expose端口对应。默认是9003，方便宝塔对应远程php调试。

- 修改了sh脚本，以对应修改过的路径

- windows下的sh脚本COPY后，会变成DOS格式。增加了```sed -i "s/\r//"```进行修复。

- 为了方便观察，修改了services的命名为bota及bota_backup

### 1.启动应用及查看应用更改为：

```
docker-compose up -d bota
```

```
docker-compose logs bota
```

### 2.备份/恢复容器内的宝塔面板更改为：

```
docekr-compose stop
docekr-compose up -d bota_backup
docekr-compose exec bota_backup sh
```

```
sh /docker_backup/export.sh
```

```
sh /docker_backup/import.sh
```



# 以下为引用原作者@ifui：

## 如何使用

> 建议使用 Liunx 或者 MAC 部署，windows用户想来是用不到这个

### 1. 安装git，或者直接下载`zip`也可以
`sudo yum install -y git`

### 2. 到你想生成项目的文件夹下执行命令
`git clone https://github.com/ifui/baota.git`

### 3. 进入项目根目录
`cd baota`

### 4. 生成配置文件
`cp .env-example .env`

### 5. 启动宝塔镜像，在项目根目录下执行命令
`docker-compose up -d app`

### 6. 查看默认登录信息
`docker-compose logs app`

## 如何进行数据备份和迁移

### 1. 首先正常部署成功后，将需要的应用程序和配置安装和设置完毕

### 2. 启动并进入`app_backup`容器，注意：接下来的操作都是在该容器下的交互命令下执行
```bash
docekr-compose stop
docekr-compose up -d app_backup
docekr-compose exec app_backup sh
```

#### 3.1 备份

> 执行成功后会在宿主机项目目录下的`app_backup/export`目录下生成`baota_backup_*.tar.gz`的数据包

`sh /app_backup/export.sh`

#### 3.2 迁移

> 将数据包放在`app_backup/export`目录下，然后执行，根据提示操作即可

`sh /app_backup/import.sh`

## 其他说明

### 目录结构

- app
  - app.sh 宝塔镜像启动脚本
  - Dockerfile
- app_backup
  - app_backup 宝塔数据备份迁移脚本
  - Dockerfile
  - export.sh 导出脚本
  - import.sh 导入脚本
- backup .env可配置，默认为宝塔备份目录
- wwwlogs .env可配置，默认为宝塔日志目录
- wwwroot .env可配置，默认为宝塔网站目录，请把你的网站放在此目录下

### .env配置说明
> 这里可以自定义端口和目录，请酌情设置，默认也可
```
# Driver
VOLUMES_DRIVER=local
# bridge / host
NETWORKS_DRIVER=bridge

# baota_app 宝塔镜像版本
APP_VERSION=latest

# PORT 开放端口
# 面板端口
BAOTA_PORT=8888
# 网站默认端口
WEB_PORT=80
# HTTPS 端口
HTTPS_PORT=443
# FTP 端口
FTP_PORT=21
# FTP 数据传输端口
FTP_DATA_PORT=20
# SSH 端口
SSH_PORT=10022
# MYSQL 端口
MYSQL_PORT=3306
# PHPMYADMIN 端口
PHPMYADMIN_PORT=888

# PATH 路径
# 网站默认路径
WEB_PATH=./wwwroot
# 日志
LOGS_PATH=./wwwlogs
# 宝塔备份
BACKUP_PATH=./backup
# 启动脚本路径
DOCKERSCRIPT_PATH=./DockerScript
```

### 常用命令

```bash
# 构建容器
docker-compose build
# 不缓存构建，执行后默认登录信息会变化
docker-compose build --no-cache
# 查看运行情况
docker-compose ps
# 启动宝塔镜像
docker-compose up -d app
# 启动宝塔数据备份迁移系统
docker-compose up -d app_backup
# 启动所有
docker-compose up -d
# 停止运行
docker-compose stop app
# 删除容器和数据卷
docker-compose down --volumes
```

## 关于作者
### ifui
邮箱：ifui@foxmail.com \
个人主页：[https://github.com/ifui](https://github.com/ifui) \
提交问题：[https://github.com/ifui/baota/issues](https://github.com/ifui/baota/issues)
