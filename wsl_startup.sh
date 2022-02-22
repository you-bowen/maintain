#!/bin/bash
export PATH=/mnt/c/Windows/System32:$PATH
win_ip_lan=$(ipconfig.exe | grep -a 192.168 | sed "/\.1.$/d"| cut -d ":" -f 2|sed "s/[[:space:]]//g")
win_ip=$(ip route show | sed -n "1p" | awk -F" " '{print $3}') # 对应win的wsl虚拟网卡的ip

function aoc(){
  # add if exist else change (add or change)
  # 3args: "keyword" "context... keyword" file_location
  line=$(cat -n $3| grep -w $1 | awk -F" " '{print $1}')
  if [ $line ]; then
    sudo sed -i "$line c\\$2" $3             # change
  else
    sudo chmod a+w $3 && sudo echo "$2" >> $3 # add
  fi
}

function pfdwin2wsl(){
    # 访问win的时候被转发到wsl, 需要先执行wsl hosts, 更新wsl的ip
    if [ $1 = "--help" ]; then
        echo "pfdwin2wsl <win_port> <wsl_port>" 
    elif [ $1 = "--reset" ]; then
        netsh.exe interface portproxy reset > /dev/null
    elif [ $1 = "--show" ]; then
        netsh.exe interface portproxy show all
    elif [ "$1" -a "$2" ]; then
        netsh.exe interface portproxy add v4tov4 listenaddress=${win_ip_lan} listenport=$1 connectaddress=wsl.local connectport=$2 > /dev/null
    elif [ $1 ]; then
        netsh.exe interface portproxy add v4tov4 listenaddress=${win_ip_lan} listenport=$1 connectaddress=wsl.local connectport=$1 > /dev/null
    fi
}

function pfdwsl2win(){
    # 访问wsl的时候被转发到win
    ## 每次win开机启动一次就行
    # make sure you have run `sudo echo 1 > /proc/sys/net/ipv4/ip_forward` in the root mode
    sudo bash -c "sudo echo 1 > /proc/sys/net/ipv4/ip_forward" # it'll be reset to '0' when reboot windows
    sudo iptables -t nat -F
    sudo iptables -t nat -A POSTROUTING -j MASQUERADE
    sudo iptables -t nat -A PREROUTING -p tcp -m tcp --dport 3389 -j DNAT --to-destination $win_ip:3389
    # 还要把wsl的22222转发到wsl的22
    sudo iptables -t nat -A PREROUTING -p tcp --dport 22222 -j REDIRECT --to-port 22
}

function wsl_hosts(){
    ### win每次开机时 wsl的ip和win上面的虚拟网卡都不一样
    ## 每次win开机的时候启动一次就行
    # 把wsl的ip添加到windows的host里面->让ida能够轻松的debug
    hosts="/mnt/c/Windows/System32/drivers/etc/hosts"
    ip=$(ip add | grep inet | grep eth0 | awk -F" " '{print $2}' | cut -d"/" -f 1)
    echo -n "wsl ip: $ip | "
    aoc "wsl.local" "$ip wsl.local" "$hosts"
}

function load(){
    if [[ $(service $1 status | grep not) ]];then 
        sudo service $1 start;
        echo "$1 just started";
    else 
        echo "$1 is already running";
    fi
}

wsl_hosts # 在win中记录wsl的ip

pfdwin2wsl --reset
pfdwin2wsl 22222 22
pfdwin2wsl 23946

pfdwsl2win

load ssh
~/apps/npc/npc.sh # start npc service if it's not running
~/apps/nebula/nebula.sh # start nebula service if it's not running
~/apps/identifier/identifier.sh # start identifier service if it's not running