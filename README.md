# Athena监控系统



## 安装&部署



### 服务端

安装后端监控系统需要先拉取[告警子系统](https://github.com/EZ4BRUCE/athena-server)和[规则配置子系统](https://github.com/EZ4BRUCE/rule-server)，在当前目录下执行以下拉取命令

拉取告警子系统：

```bash
git clone git@github.com:EZ4BRUCE/athena-server.git
```

拉取规则配置子系统：

```bash
git clone git@github.com:EZ4BRUCE/rule-server.git
```

拉取成功后，在当前目录下执行

```bash
docker-compose up
```

即可运行监控服务端



### Agent

拉取[Agent端](https://github.com/DeltaDemand/athena-agent)

```bash
git clone git@github.com:DeltaDemand/athena-agent.git
```

进入athena-agent目录，执行以下docker命令即可启动Agent端：

```bash
#构建docker镜像
docker build -t athena-agent .
#运行一个agent实例
docker run --name user-agent1 --network athena_frontend athena-agent
```



