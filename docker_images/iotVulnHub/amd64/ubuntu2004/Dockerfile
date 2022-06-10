FROM amd64/ubuntu

RUN sed -i -r "s/[a-z]+.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list

RUN apt-get update && apt-get install -y vim wget git \
    && DEBIAN_FRONTEND=noninteractive apt install -y tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' >/etc/timezone

