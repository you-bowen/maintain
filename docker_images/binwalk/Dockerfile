FROM utils/ubuntu:arm64

WORKDIR /root

RUN apt install --no-install-recommends -y squashfs-tools \
    && git clone https://github.com/ReFirmLabs/binwalk --depth=1 \
    && cd binwalk && python3 setup.py install && cd && rm -rf binwalk \
    && git clone https://github.com/devttys0/sasquatch --depth=1 \
    && cd && cd sasquatch \
    && apt-get -y install build-essential liblzma-dev liblzo2-dev zlib1g-dev \
    && ./build.sh 

# comment it for 'noentry'
ENTRYPOINT ["binwalk"]
