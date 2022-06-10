FROM arm64v8/ubuntu

WORKDIR /root

RUN sed -i "s/ports.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list
RUN apt-get update

RUN apt install --no-install-recommends -y squashfs-tools git python3 build-essential liblzma-dev liblzo2-dev zlib1g-dev

RUN git clone https://github.com/ReFirmLabs/binwalk --depth=1 \
    && cd binwalk && python3 setup.py install && cd && rm -rf binwalk \
    && git clone https://github.com/devttys0/sasquatch --depth=1 \
    && cd && cd sasquatch \
    && ./build.sh 

ENTRYPOINT [ "binwalk" ]