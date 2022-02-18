# Athena监控系统



## 安装&部署

先拉取本仓库并进入athena目录

```bash
#拉取本仓库
git clone https://github.com/EZ4BRUCE/athena.git
#进入athena目录
cd athena
```



### 告警服务部署

安装后端监控系统需要先拉取[告警子系统](https://github.com/EZ4BRUCE/athena-server)和[规则配置子系统](https://github.com/EZ4BRUCE/rule-server)，在当前目录下执行以下拉取命令

拉取告警子系统：

```bash
git clone https://github.com/EZ4BRUCE/athena-server.git
```

拉取规则配置子系统：

```bash
git clone https://github.com/EZ4BRUCE/rule-server.git
```

拉取成功后，在当前目录下执行，即可运行监控服务端

```bash
docker-compose up --build
```

如果修改了告警邮箱或SMTP服务邮箱，则需要重启告警服务更新配置（修改告警规则为热更新，无需重启）：

```bash
docker restart athena-server
```

查看日志文件：

```bash
#进入athen-server容器终端
docker exec -it athena-server /bin/sh
cd storage/logs&&ls
```



#### 规则配置服务前端页面

使用swagger实现接口文档以及测试，启动后访问以下链接即可：

#本机测试
http://localhost:1016/swagger/index.html

#腾讯云
http://1.12.242.39:1016/swagger/index.html

#阿里云
http://112.74.60.132:1016/swagger/index.html

点击`try it out`，滑动到对应的测试输入框，输入后按下`execute`即可测试（注意，字符串要加 “”）



### Agent部署

在需要被监控的主机上拉取[Agent端](https://github.com/DeltaDemand/athena-agent)

```bash
git clone https://github.com/DeltaDemand/athena-agent.git
```

进入athena-agent目录，执行以下docker命令即可启动Agent端：

```bash
#构建docker镜像
docker build -t athena-agent ./athena-agent

#本机测试：使用docker内网
docker run -d -i --name host01 --network athena_frontend athena-agent -aggregationTime=5 -checkAlive=30 -cpuR=10 -memR=10 -diskR=10 -cpu_memR=10 -group=group01 -name=agent01

#云服务器测试
#阿里云
docker run -d --name host01 athena-agent -ip="112.74.60.132" -aggregationTime=5 -checkAlive=30 -cpuR=10 -memR=10 -diskR=10 -cpu_memR=10 -group=group01 -name=agent01
#腾讯云
docker run -d --name host01 athena-agent -ip="1.12.242.39" -checkAlive=30 -cpuR=10 -memR=10 -diskR=10 -cpu_memR=10 -group=group01 -name=agent01
# -group string
#        etcd上Agent分组 (default "g01")
# -name string
#        etcd上Agent名字 (default "A01")
# -cpuR int
#        cpu上报时间间隔 (default 60)
```

告警测试：

```bash
#进入agent终端
docker exec -it host01 /bin/sh
#运行程序，使cpu、内存等数据有所波动
./test/poseidon -goN=12 -append=10000000 -sleep=100000
# -append int                                 
#        每个goroutine内append字符串的次数     
#  -goN int                                    
#        创造goroutine跑死循环个数 (default 10)
#  -sleep int                                  
#        每次循环睡眠时间(ns)                  
#  -times int                                  
#        死循环时间(s) (default 90) 
```



### 服务端压力测试

同时启动多个agent测试**gRPC服务、Agent注册、Report接收、邮件收发**功能是否正常

在athena目录下（需要本机build好Agent镜像）：

```bash
#运行预设的测试脚本

#赋予权限
chmod +x ./test.sh
#运行预设的测试脚本：第一个参数为组别group，第二个参数为开启个数num，第三个参数为Agent要连接的服务器
./test.sh 1 10 local
#腾讯云
./test.sh 1 10 "1.12.242.39"
#阿里云
./test.sh 1 10 "112.74.60.132"

#删除刚才创建的容器
#赋予权限
chmod +x ./delete.sh
#第一个参数为刚才创建的容器个数num
./delete.sh 10
```

