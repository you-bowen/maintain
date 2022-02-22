echo "U are using Mac! I know."
__conda="/opt/homebrew/Caskroom/miniconda/base"
# use gnu cmds in your mac.
# add a "gnubin" directory to your PATH from your bashrc like:
# PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

# use gsed if exist
gsed_fail=$(which gsed | grep "found")
if [ $gsed_fail ];then sed=sed;else sed=gsed;fi

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
alias qq="ka QQ; open -a QQ"
alias clash="ka ClashX; open -a ClashX"
alias trending="~/apps_docker/github_trending/run.sh"
alias disable_sleep="sudo pmset -b sleep 0; sudo pmset -b disablesleep 1"
alias enable_sleep="sudo pmset -b sleep 1; sudo pmset -b disablesleep 0"
# check sleep status
a=$(sudo pmset -g custom | egrep -c '^\ sleep.*0$')
if [ $a = 2 ]; then 
    echo "warning: you are keeping sleep disabled, which is dangerous!"
    echo "use 'disable_sleep' to stop it."
fi
function cpu_host_update(){
    # set host for {cpu}(my windows)
    if [ $1 -a $1 = "--help" ]; then
        echo "useage: cpu_host_update <hostname>"
        echo "you can use \`cpu_host_update \$(sudo find_cpu)\` to update automatically."
    elif [ $1 ]; then 
        sudo gsed -i "s/.*cpu/$1 cpu/g" /etc/hosts
    else
        default_host="42.192.46.157"
        sudo gsed -i "s/.*cpu/${default_host} cpu/g" /etc/hosts
    fi
}
function push-wsl(){
    if [[ $1 ]]; then new_file=$1; else new_file=$HOME'/Downloads/'$(ls -t ~/Downloads | sed -n "1p"); fi
    scp -P 22222 $new_file ybw@cpu:~/pwn/.target
}