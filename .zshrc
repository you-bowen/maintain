export ZSH="$HOME/.oh-my-zsh"
UNAME=$(uname -a)
# iot
alias webrepl="python3 ~/apps/webrepl/webrepl_cli.py -p '900900'"
alias serial="ls /dev | grep usb"
alias flasher="python3 ~/repos/nodemcu-pyflasher/Main.py &"
# network
alias proxyoff="export https_proxy='' http_proxy='' all_proxy=''"
alias proxyon="export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890"
alias pon="proxyon"
alias poff="proxyoff"
alias pchain="proxychains4"
alias google="curl google.com"
alias baidu="curl baidu.com"
alias ipip='echo "public IP addr: $(curl -s http://myip.ipip.net)"'
function ipof(){
  ping $1 -c 1 | sed -n "1p" | cut -d '(' -f2|cut -d ')' -f1;
}
function host_alive(){
  a=$(ping $1 -c 1 -t 1 | grep "1 packets received")
  if [[ $a ]]; then echo "alive";fi
}
# apps
alias nebula="sudo ~/apps/nebula/nebula -config /etc/nebula/config.yaml > ~/log/nebula.log 2>&1 &"
alias nebula_restart="sudo kill -9 \$(pgrep nebula); nebula"
# pwn
alias ida-server-x86="cd ~/pwn/.server && ./linux_server"
alias ida-server-x64="cd ~/pwn/.server && ./linux_server64"
alias pwn="code ~/pwn"
# ctf-web
alias rustscan='docker run -it --rm --name rustscan rustscan/rustscan:2.0.0'
alias trojan="echo '<?php @eval(\$_POST['attack']);?>'"
# shortcuts
alias maintain="cd ~/maintain && clash && pon && sleep 0.3 && git pull && ka clash && poff && exec zsh"
alias pmod="sudo chmod a+x *" # power mod
alias ggg="gaa && gcmsg '..' && gp"
alias gitback="git reset . && git checkout . && git clean -df" # git back (to origin)
alias cae="conda activate"
alias cde="conda deactivate"
alias sizeof="du -sh"
alias t="tmux"
alias pg="pgrep"
alias ...="cd ../.."
alias k9="sudo kill -9"
alias ka="sudo killall"
alias hhh="hexo clean && hexo g && hexo s"
alias history_fix="mv ~/.zsh_history ~/.zsh_history_bad && strings ~/.zsh_history_bad > ~/.zsh_history && fc -R ~/.zsh_history"
function code--(){
  code --remote ssh-remote+$1 $2 
}
function ssl_cert_install(){
  acme.sh --install-cert -d $1 \
  --cert-file      $2/cert.pem  \
  --key-file       $2/key.pem  \
  --fullchain-file $2/fullchain.pem \
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
  alias service="brew services"
  alias pd="prlctl"
  alias mysql="/Applications/phpstudy/Extensions/MySQL5.7.28/bin/mysql"
  alias burp="cd ~/Desktop/BurpSuite2020.12 && nohup ./BURP.sh > /dev/null &"
  alias sed="gsed"
  alias wsl="ssh ybw@cpu -p 22222"
  alias wifi='/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport'
  alias code-wsl-pwn="code --remote ssh-remote+wsl /home/ybw/pwn"
  alias sm="open -a ShareMouse"
  alias sm_restart="killall ShareMouse && open -a ShareMouse"
  function cpu_host(){
    # set host for {cpu}(my windows)
    sudo gsed -i "s/.*cpu/$1 cpu/g" /etc/hosts;
  }

  function cpu_host_update(){
    # wifi_name=$(wifi -I| awk -F: '/ SSID/{print $2}' | sed 's/^[ \t]*//g')
    if [[ -z $(host_alive 192.168.100.3) ]]; then 
      cpu_host "42.192.46.157"; 
      echo -n "cpu not alive | ";
    else
      cpu_host "192.168.100.3";
    fi
    echo "host {cpu} updated"
  }
  function push-wsl(){
    if [[ $1 ]]; then new_file=$1; else new_file=$HOME'/Downloads/'$(ls -t ~/Downloads | sed -n "1p"); fi
    scp -P 22222 $new_file ybw@cpu:~/pwn/.target
    # scp -P 22222 $1 ybw@cpu:/mnt/c/Users/27564/Desktop/pwnfiles
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
  alias sm="/mnt/c/Program\ Files\ \(x86\)/ShareMouse/ShareMouse.exe &"
  alias sm_restart="taskkill.exe /IM  Share\* && sm"
  alias ida-x64="/mnt/c/pwntools/ida75/75ida64.exe -i"
  alias ida-x86="/mnt/c/pwntools/ida75/75ida.exe -i"

  win_ip_lan=$(ipconfig.exe | grep -a 192.168 | sed "/\.1.$/d"| cut -d ":" -f 2|sed "s/[[:space:]]//g")
  win_ip=$(ip route show | sed -n "1p" | awk -F" " '{print $3}') # 对应win的wsl虚拟网卡的ip
  function pfdwin2wsl(){
    netsh.exe interface portproxy reset > /dev/null
    netsh.exe interface portproxy add v4tov4 listenaddress=$1 listenport=22222 connectaddress=wsl.local connectport=22 > /dev/null
    netsh.exe interface portproxy add v4tov4 listenaddress=$1 listenport=23946 connectaddress=wsl.local connectport=23946 > /dev/null
  }
  function pfdwsl2win(){
    # make sure you have run `sudo echo 1 > /proc/sys/net/ipv4/ip_forward` in the root mode
    sudo iptables -t nat -t nat -F
    sudo iptables -t nat -A POSTROUTING -j MASQUERADE
    sudo iptables -t nat -A PREROUTING -p tcp -m tcp --dport 3389 -j DNAT --to-destination $win_ip:3389
    # 还要把wsl的22222转发到wsl的22
    sudo iptables -t nat -A PREROUTING -p tcp --dport 22222 -j REDIRECT --to-port 22
  }

  function wsl_hosts(){
    ### wsl每次启动时的ip和win上面的虚拟网卡都不一样
    
    # 把wsl的ip添加到windows的host里面->让ida能够轻松的debug
    hosts="/mnt/c/Windows/System32/drivers/etc/hosts"
    ip=$(ip add | grep inet | grep eth0 | awk -F" " '{print $2}' | cut -d"/" -f 1)
    echo -n "wsl ip: $ip | "
    aoc "wsl.local" "$ip wsl.local" "$hosts"

    # 把win的ip加入到wsl的host里面，如果局域网ip变了就重新进行端口转发，端口转发是为了通过win访问wsl
    # hosts="/etc/hosts"
    # echo -n "win ip: $1 | "
    # win_ip_not_change=$(cat $hosts | grep "$1 win.local")
    # if [ $win_ip_not_change ]; then 
    #   echo "not changed."
    # else
    #   echo "Forwarding..."
    #   aoc "win.local" "$1 win.local" "$hosts"
    #   pfdwin2wsl $1
    # fi
  }
  function load(){
    if [[ $(service $1 status | grep not) ]];then sudo service $1 start;echo "$1 just started";else echo "$1 is already running";fi
  }

  # wsl_hosts $win_ip_lan
  load ssh
  ~/apps/npc/npc.sh # start npc service if it's not running
  ~/apps/nebula/nebula.sh # start nebula service if it's not running
elif [[ $UNAME =~ "Android" ]]; then
  echo "U are using Android! I know"
  sshd

else
  __conda="$HOME/.miniconda"
  function clash(){
    if [ $(pgrep clash) ]; then 
      echo 'clash is running';
    else 
      ~/apps/clash/clash -d ~/apps/clash/ > /dev/null 2>&1 &;
      echo 'clash launched';
    fi
  }
fi

# key bindings
bindkey \^U backward-kill-line

if [ -e "$ZSH/themes/ybw-ys.zsh-theme" ]; then ZSH_THEME="ybw-ys"; else ZSH_THEME="ys"; fi


plugins=(git
gitignore
macos
cp
gitignore
colored-man-pages
extract
sudo
zsh-autosuggestions
# zsh-autocomplete
zsh-syntax-highlighting
autojump
)
	
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50

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

export PATH=$HOME/maintain/tools:$HOME/pwn/tools:$PATH
