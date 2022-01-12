FROM amd64/ubuntu

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    && sed -i "s/archive.ubuntu.com/mirrors.cqupt.edu.cn/g" /etc/apt/sources.list \
    && sed -i "s/security.ubuntu.com/mirrors.cqupt.edu.cn/g" /etc/apt/sources.list \
    && sed -i "s/http/https/g" /etc/apt/sources.list \
    && apt-get update \
    && apt-get install --no-install-recommends -y vim wget git \
    && DEBIAN_FRONTEND=noninteractive apt install -y tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' >/etc/timezone

RUN rm -rf /var/lib/apt/lists/* 
