# EZ-Docker 使用说明

这是EasyBot主程序的Docker镜像仓库

## 1. 拉取镜像
```bash
docker pull 123165/ez-docker:latest
```

## 2. 推荐的基础运行命令（后台运行）
让容器将容器内的 5000 和 26990 端口暴露到宿主机，并确保服务监听所有网卡（0.0.0.0）：
```bash
docker run -d \
  --name ez-docker \
  -p 5000:5000 -p 26990:26990 \
  --restart unless-stopped \
  123165/ez-docker:latest
```
说明：
- `-p HOST:CONTAINER`：端口映射，宿主机访问 `http://localhost:5000` 将转发到容器内的 5000。
- `--restart unless-stopped`：容器崩溃或宿主重启时自动重启。

## 3. 前台运行（用于调试）
```bash
docker run --rm -it \
  -p 5000:5000 -p 26990:26990 \
  123165/ez-docker:latest
```
`--rm`：容器退出后自动删除，适合临时调试。

## 4. 常用命令
```bash
# 列出运行容器
docker ps

# 查看端口映射
docker port ez-docker

# 查看日志（实时追踪）
docker logs -f ez-docker

# 进入容器（调试）
docker exec -it ez-docker sh

# 停止 / 启动 / 删除容器
docker stop ez-docker
docker start ez-docker
docker rm ez-docker

# 升级镜像并替换容器
docker pull 123165/ez-docker:latest
docker stop ez-docker && docker rm ez-docker
# 再运行之前的 docker run 命令
```

## 5. 验证与排查步骤（访问不到时）
1. 确认容器在运行：
   ```bash
   docker ps
   ```
2. 查看端口映射是否正确（应显示类似 `0.0.0.0:5000->5000/tcp`）：
   ```bash
   docker port ez-docker
   ```
3. 检查容器内进程是否在监听 0.0.0.0：
   ```bash
   docker exec -it ez-docker sh
   # 容器内运行：
   ss -lntp | egrep '5000|26990'    # 或 netstat -tln
   ```
   - 如果只看到 `127.0.0.1:5000`，说明服务仍然绑定到本地回环，需设置 `ASPNETCORE_URLS` 或修改 appsettings.json 使其绑定 `0.0.0.0`。
4. 在宿主机测试：
   ```bash
   curl -v http://localhost:5000
   ```
5. 检查防火墙：如果在远程服务器上，确认云安全组或 iptables 没有阻止这些端口。
6. 查看服务日志获取更多信息：
   ```bash
   docker logs -f ez-docker
   ```
