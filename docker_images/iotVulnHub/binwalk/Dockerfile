FROM sasquatch
# this file is for grouped container

RUN apt install --no-install-recommends -y squashfs-tools python3 python3-dev iputils-ping net-tools nmap telnet
    
COPY ./binwalk /binwalk

RUN cd binwalk && python3 setup.py install && cd && rm -rf binwalk

# workdir is essencial because binwalk in / will cause bug
WORKDIR /root
# comment it for 'noentry'
ENTRYPOINT ["binwalk", "--run-as=root"]
