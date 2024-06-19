#!/bin/bash

# 使用 getopts 命令解析命令行参数
while getopts ":d:m:" opt; do
    case ${opt} in
        d )
            docker_path=$OPTARG
            ;;
        m )
            model_path=$OPTARG
            ;;
        \? )
            echo "Invalid option: $OPTARG"
            ;;
    esac
done

echo "Docker path is: $docker_path"
echo "Model path is: $model_path"

# 检查 Docker 镜像中是否存在 tp_inference
if docker inspect tp_inference &> /dev/null; then
    echo "Docker 镜像中已存在 tp_inference"
else
    echo "Docker 镜像中不存在 tp_inference，正在加载..."
    docker load -i $docker_path/ipex-llm-2-1-100.tar
fi

docker run -it -d --name tp_inference --privileged=true -v $model_path:/media ipex-llm:2.1.100 
