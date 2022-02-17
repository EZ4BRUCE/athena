#!/bin/bash
group=$1
num=$2
ip=$3
i=1
while [ $i -le $num ]
do
    if [ $ip == "local" ]
    then 
        docker run -d --name host$i --network athena_frontend athena-agent -group=group$group -name=agent$i
    else
        docker run -d --name host$i athena-agent -ip=$ip -group=group$group -name=agent$i
    fi
    let i++
done

echo "已创建$2个agent"