plugins=()
# TODO: https://thevaluable.dev/zsh-completion-guide-examples/
export ZSH="$HOME/.oh-my-zsh"
export PATH=$HOME/maintain/tools:$HOME/pwn/tools:$PATH
export PATH=$PATH:$HOME/.pkg_uninstaller
export GITHUB_USER="you-bowen"
# ipython opens $EDITOR when press `v` or `F2`
export EDITOR=vim
plugins+=(
    dk    # docker
    iot   # iot
    ctf   # ctf
    ops   # 一些比较基础、通用的运维操作
    proxy # 代理相关
    leecode # leecode 笔记快速创建
)
alias open="open -a"
alias nebula="sudo ~/apps/nebula/nebula -config /etc/nebula/config.yaml > ~/log/nebula.log 2>&1 &"
alias nebula_restart="sudo kill -9 \$(pgrep nebula); nebula"
alias maintain="cd ~/maintain && clash && pon && sleep 0.3 && git pull && ka clash && poff && exec zsh"
alias twrp="fastboot flash recovery $1"
alias hhh="hexo clean && hexo g && hexo s"
alias wnb="watch -n 1 nbtest"
alias i="ipython --profile=ybw"
alias p3="python3"
alias p2="python2"
alias emulator="~/Library/Android/sdk/emulator"
alias tr="trans"
alias lo="localhost"
alias cs="changeSource"
function codej(){
    j $1 && code . && popd
}
function clash(){
    if [ $(pgrep clash) ]; then
        echo 'clash is running';
    else
        ~/apps/clash/clash -d ~/apps/clash/ > ~/log/clash.log 2>&1 &;
        echo 'clash launched';
    fi
}

# >>> load plugin by system
UNAME=$(uname -a)
if [[ $UNAME =~ "Darwin" ]]; then
    plugins+=(darwin)
    elif [[ $UNAME =~ "WSL2" ]]; then
    plugins+=(wsl)
    elif [[ $UNAME =~ "Android" ]]; then
    echo "U are using Android! I know"
    sshd
else
    __conda="$HOME/.miniconda"
fi
# >>>

# key bindings
bindkey \^U backward-kill-line

if [ -e "$ZSH/themes/ybw-ys.zsh-theme" ]; then ZSH_THEME="ybw-ys"; else ZSH_THEME="ys"; fi
plugins+=(
    aliases
    git
    gitignore
    macos
    cp
    gitignore
    colored-man-pages
    extract
    sudo
    zsh-autosuggestions
    zsh-syntax-highlighting
    autojump
    you-should-use
    docker
    docker-compose
    web-search
)

DISABLE_AUTO_UPDATE=true
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
conda_init; nvm_init
# tabby sftp support
precmd () { echo -n "\x1b]1337;CurrentDir=$(pwd)\x07" }

export PNPM_HOME="/Users/flag/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
