# 运维
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
function tarf(){
    local src="$1.tgz"
    local dst="$1"
    tar cfzv $src $dst
}
# 一键创建仓库，进行初始化，需要指定仓库名
function grepo(){
    git init
    git add .
    git commit -m'..'
    git branch -M main
    git remote add origin https://github.com/$GITHUB_USER/$1.git
    git push -u origin main
}


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
    lsof -i TCP:$1 | grep LISTEN | awk '{print $2}' | xargs kill -9 
}
