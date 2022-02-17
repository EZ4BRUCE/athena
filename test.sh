#!/bin/bash
n=$2
g=$1
for i in {1..10}
do
    docker run -d --name host$i --network athena_frontend athena-agent -group=group$g -name=agent$i
done

echo "已创建$1个agent"