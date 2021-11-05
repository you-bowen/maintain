#!/bin/bash
# 需要换源的程序
# pip docker apt brew npm 
# 三大镜像站
# 阿里   https://developer.aliyun.com/mirror/
# 清华   https://mirrors.tuna.tsinghua.edu.cn/
# 中科大 https://mirrors.ustc.edu.cn/
echo "changing $1 source..."
if [ "$1" == "apt" ]; then
    source="/etc/apt/sources.list"
    sudo cp $source "$source.bak"
    data="deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse\n# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse\ndeb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse\n# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse\ndeb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse\n# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse\ndeb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse\n# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse multiverse"
    sudo echo -e $data > $source
elif [ "$1" == "pip" ]; then
    data="https://pypi.tuna.tsinghua.edu.cn/simple"
    pip3 config set global.index-url $data
elif [ "$1" == "docker" ]; then
    source="/etc/docker/daemon.json"
    mkdir "/etc/docker"
    data='{\n\t"registry-mirrors": ["https://ustc-edu-cn.mirror.aliyuncs.com/"],\n\t"log-driver":"json-file",\n\t"log-opts": {"max-size":"500m", "max-file":"3"}\n}'
    echo -e $data && read -p "copy now"
    sudo vim $source
elif [ "$1" == "npm" ]; then
    data=https://registry.npm.taobao.org
    npm config set registry $data
    
    tips="you can run <sudo systemctl daemon-reload && sudo systemctl restart docker>"
else 
    echo -e "usage: ./cs.sh <app>, \n\tSupported apps: apt pip docker"
fi
echo -e "over.\n" $tips
