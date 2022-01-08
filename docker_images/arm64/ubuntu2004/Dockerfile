FROM arm64v8/ubuntu

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    && sed -i "s/ports.ubuntu.com/mirrors.cqupt.edu.cn/g" /etc/apt/sources.list \
    && sed -i "s/http/https/g" /etc/apt/sources.list \
    && apt-get update \
    && apt-get install --no-install-recommends -y vim-tiny wget git \
    && rm -rf /var/lib/apt/lists/*
