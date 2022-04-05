alias proxyoff="export https_proxy='' http_proxy='' all_proxy=''"
alias proxyon="export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890"
alias pon="proxyon"
alias poff="proxyoff"
alias pchain="proxychains4"
alias google="curl google.com"
alias baidu="curl baidu.com"
alias ipip='echo "public IP addr: $(curl -s http://myip.ipip.net)"'
function 3px(){
    # only one arg -> 127.0.0.1
    poff
    if [ -z $2 ]; then 
        export https_proxy=http://127.0.0.1:$1
    else 
        export https_proxy=http://$1:$2
    fi
    export http_proxy=$https_proxy all_proxy=$https_proxy
}
function 2px(){
    poff
    # only one arg -> 127.0.0.1
    if [ -z $2 ]; then 
        export https_proxy=http://127.0.0.1:$1
    else 
        export https_proxy=http://$1:$2
    fi
    export http_proxy=$https_proxy 
}
