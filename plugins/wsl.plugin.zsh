__conda="$HOME/.miniconda"
user="/mnt/c/Users/27564"
desktop="$user/Desktop"
downloads="$user/Downloads"
echo "U are using WSL2! I know."
export PATH=/mnt/c/Windows/System32:$PATH
alias ggg="gaa && gcmsg '..' && /mnt/c/Program\ Files/Git/cmd/git.exe push"
alias sm="/mnt/c/Program\ Files\ \(x86\)/ShareMouse/ShareMouse.exe &"
alias sm_restart="taskkill.exe /IM Share\* /F && sm"
alias ida-x64="/mnt/c/pwntools/ida75/75ida64.exe -i"
alias ida-x86="/mnt/c/pwntools/ida75/75ida.exe -i"
win_ip_lan=$(ipconfig.exe | grep -a 192.168 | sed "/\.1.$/d"| cut -d ":" -f 2|sed "s/[[:space:]]//g")
win_ip=$(ip route show | sed -n "1p" | awk -F" " '{print $3}') # 对应win的wsl虚拟网卡的ip