# 运维
alias tarAfromB="tar cfzv $1 $2"
alias pmod="sudo chmod a+x *" # power mod
alias ggg="gaa && gcmsg '..' && gp"
alias gitback="git reset . && git checkout . && git clean -df" # git back (to origin)
alias ca="conda activate"
alias cda="conda deactivate"
alias sizeof="du -sh"
alias t="tmux"
alias pg="pgrep"
alias ...="cd ../.."
alias k9="sudo kill -9"
alias ka="sudo killall"
alias history_fix="mv ~/.zsh_history ~/.zsh_history_bad && strings ~/.zsh_history_bad > ~/.zsh_history && fc -R ~/.zsh_history"
alias lt="ls -t"
# 一件创建仓库，进行初始化，需要你的目录名 == 仓库名
alias grepo="git init && \
            gaa && gcmsg '..' && \
            gb -M main && \
            git remote add origin https://github.com/$GITHUB_USER/${PWD##*/}.git && \
            gp -u origin main"


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
