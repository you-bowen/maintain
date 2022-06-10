FROM arm64v8/ubuntu

RUN sed -i "s/ports.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y build-essential liblzma-dev liblzo2-dev zlib1g-dev 

COPY ./squashfs4.3 /squashfs4.3

RUN cd squashfs4.3/squashfs-tools && make && make install
