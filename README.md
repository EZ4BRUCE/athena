# Athena监控系统



## 安装&部署

先拉取本仓库并进入athena目录

```bash
#拉取本仓库
git clone https://github.com/EZ4BRUCE/athena.git
#进入athena目录
cd athena
```



### 服务端

安装后端监控系统需要先拉取[告警子系统](https://github.com/EZ4BRUCE/athena-server)和[规则配置子系统](https://github.com/EZ4BRUCE/rule-server)，在当前目录下执行以下拉取命令

拉取告警子系统：

```bash
git clone https://github.com/EZ4BRUCE/athena-server.git
```

拉取规则配置子系统：

```bash
git clone https://github.com/EZ4BRUCE/rule-server.git
```

拉取成功后，在当前目录下执行

```bash
docker-compose up --build
```

即可运行监控服务端



### Agent部署

拉取[Agent端](https://github.com/DeltaDemand/athena-agent)

```bash
git clone https://github.com/DeltaDemand/athena-agent.git
```

进入athena-agent目录，执行以下docker命令即可启动Agent端：

```bash
#进入athena-agent目录
cd athena-agent
#构建docker镜像
docker build -t athena-agent .
#运行一个agent实例
docker run -d --name user-agent1 --network athena_frontend athena-agent

#本机测试：使用docker内网
docker run -d -i --name user-agent1 --network athena_frontend athena-agent -aggregationTime=5 -checkAlive=30 -cpuR=10 -memR=10 -diskR=10 -cpu_memR=10

#云服务器测试
#阿里云
docker run -d --name user-agent1 athena-agent -ip="112.74.60.132" -checkAlive=30 -cpuR=10 -memR=10 -diskR=10 -cpu_memR=10
#腾讯云
docker run -d --name user-agent1 athena-agent -ip="1.12.242.39" -checkAlive=30 -cpuR=10 -memR=10 -diskR=10 -cpu_memR=10
```



### 规则配置前端页面

使用swagger实现接口文档以及测试，启动后访问以下链接即可：

```
#本地
localhost:1016/swagger/index.html



#腾讯云
http://1.12.242.39:1016/swagger/index.html
```

点击`try it out`即可测试



edwe1414!
