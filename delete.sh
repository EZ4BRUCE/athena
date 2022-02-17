#!/bin/bash
num=$1
i=1
while [ $i -le $num ]
do
    docker rm -v host$i
    let i++
done

echo "已删除$1个agent"