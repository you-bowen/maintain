export ZSH="$HOME/.oh-my-zsh"
alias proxyOff="https_proxy='' http_proxy='' all_proxy=''"
alias proxyOn="https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890"
alias google="curl google.com"
alias baidu="curl baidu.com"
alias idax86="cd ~/ida && ./linux_server"
alias idax64="cd ~/ida && ./linux_server64"
alias pwn="code ~/pwn"
# for ubuntu Desktop
# for m1 MACbook
alias pd="prlctl start"
# for WSL2
export User="27564"
export Desktop="/mnt/c/Users/$User/Desktop"
export Downloads="/mnt/c/Users/$User/Downloads"
alias pwncp="cp /mnt/c/Users/27564/Desktop/pwnfiles/* ~/pwn/target && chmod a+x ~/pwn/target/*"


ZSH_THEME="ys"

plugins=(git
gitignore
extract
sudo
zsh-autosuggestions
zsh-syntax-highlighting
)
	
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"

[[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && source $HOME/.autojump/etc/profile.d/autojump.sh

autoload -U compinit && compinit -u
source $ZSH/oh-my-zsh.sh

