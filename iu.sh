#!/bin/bash

# 定义变量 a='test' 中间没有空格
install_info="$HOME/.ubt_install_info"
jumpIfDoneElseDo()  { if [ ! $(cat "$install_info" | grep "$1") ] ; then $2 ; fi }
markDone()          { echo "$1" >> "$install_info"; }
tips()              { clear;echo $1; }
menu()              { id=0;for i in $@;do echo $id. $i;((id++));done;read -p "input your options(eg: '012'):" options; }
exec_choice()       { id=0;for i in $@;do if [[ $options =~ "$id" ]];then $i;fi;((id++));done }

echo "" >> "$install_info"
menu "base"\
     "ctf"\
     "docker"\
     "git"\
     "ubt_Desktop_essential"\
     "zsh(twice)"\
     "nvim(plugins)"

base(){
    core(){
        echo "installing base modules..."
        sudo apt-get update && sudo apt-get install -y wget vim curl neofetch zsh htop ssh python3-pip gcc neovim git proxychains sudo ssh
        sudo apt-get install -y iproute2 net-tools
        sudo vim /etc/ssh/sshd_config
        sudo service ssh restart
        sudo ln -s /usr/bin/python3 /usr/bin/python # mac中无效
        # install my tools
        sudo ln -s ~/maintain/tools/* /usr/local/bin/
        sudo chmod a+x /usr/local/bin/*
        
        markDone "base_core"
    }
    jumpIfDoneElseDo "base_core" core 
    echo "you can run:  systemctl enable ssh"
}
ctf(){
    menu "base" "pwn" "re" "firmware" "x86 suppport" "Penetration"
    base(){
        # pwntools gdb
        sudo apt-get install -y python3 python3-pip python3-dev git libssl-dev libffi-dev build-essential gdb gdb-multiarch
        markDone "ctf_base" 
    }
    pwn(){
        # repos_pwn
        repos_dir="$HOME/repos_pwn" 
        mkdir "$repos_dir"
        pip3 install pwntools

        # ropgadget
        sudo pip install capstone
        cd "$repos_dir" && git clone https://github.com/JonathanSalwan/ROPgadget
        cd ROPgadget && python setup.py install
            # cp -r scripts /home/ybw/.local/lib/python3.9/site-packages/ROPGadget-6.6.dist-info

        # pwndbg    
        cd "$repos_dir" && git clone https://github.com/pwndbg/pwndbg
        cd pwndbg && ./setup.sh

        # pwngdb
        cd "$repos_dir" && git clone https://github.com/scwuaptx/Pwngdb.git 

        # modify ~/.gdbinit
        echo -e "source $repos_dir/pwndbg/gdbinit.py\nsource $repos_dir/Pwngdb/pwngdb.py\nsource $repos_dir/Pwngdb/angelheap/gdbinit.py\ndefine hook-run\npython\nimport angelheap\nangelheap.init_angelheap()\nend\nend" > "$HOME/.gdbinit"

        # one_gadget
        sudo apt-get install -y ruby
        sudo gem install one_gadget

        # pwn project (includes buuctf libc)
        cd ~ && git clone https://github.com/you-bowen/pwn


        # glibc_all_in_one
        cd "$repos_dir" && git clone https://github.com/matrix1001/glibc-all-in-one
        cd glibc-all-in-one || exit
        ./download 2.23-0ubuntu11.3_amd64   # 本地调试 ubt16 x64
        ./download 2.23-0ubuntu11.3_i386    # 本地调试 ubt16 x86


        # LibcSearcher
        cd "$repos_dir" && git clone https://github.com/lieanu/LibcSearcher.git
        cd LibcSearcher && sudo python3 setup.py develop
        cd libc-database || exit 
        ./add ~/repos_pwn/glibc-all-in-one/libs/2.23-0ubuntu11.3_i386/libc.so.6     # 本地调试 ubt16 x86
        ./add ~/repos_pwn/glibc-all-in-one/libs/2.23-0ubuntu11.3_amd64/libc.so.6    # 本地调试 ubt16 x64
        ./add ~/pwn/buuoj/16/64/libc.so.6   # 线上调试 ubt16 x64
        ./add ~/pwn/buuoj/16/32/libc.so.6   # 线上调试 ubt16 x86
        
        # patchElf
        sudo apt-get install -y autoconf automake libtool 
        cd "$repos_dir" && git clone https://github.com/NixOS/patchelf
        cd patchelf || exit
        ./bootstrap.sh
        ./configure
        make
        sudo make install
        make check
    }
    re(){
        repos_dir="$HOME/repos_re" 
        mkdir "$repos_dir"
        # deflat
        cd "$repos_dir" && git clone https://github.com/cq674350529/deflat 
    }
    firmware(){
        repos_dir="$HOME/repos_firmware" 
        mkdir "$repos_dir"
        # binwalk
        sudo apt-get install -y binwalk 
    }
    x86(){
        # x86 support
        sudo dpkg --add-architecture i386
        sudo apt-get update
        sudo apt-get dist-upgrade
        sudo apt-get install -y libc6:i386
    }
    pene(){
        repos_dir="$HOME/repos_firmware" 
        mkdir "$repos_dir"
        # sqlmap
        cd "$repos_dir" && git clone https://github.com/sqlmapproject/sqlmap
        # oneForAll
        cd "$repos_dir" && git clone https://github.com/shmilylty/OneForAll
        # JsFinder
        cd "$repos_dir" && git clone https://github.com/Threezh1/JSFinder
        # dirsearch
        cd "$repos_dir" && git clone https://github.com/maurosoria/dirsearch
    }
    jumpIfDoneElseDo "ctf_base" base 
    funcs=(base pwn re firmware x86 pene)
    exec_choice ${funcs[*]}
}
docker(){
    menu "base" "change_source" "portainer" "netdata" "nps"
    base(){ read -p "for linux user!" xxx; curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun; }
    change_source(){ echo "tobe written"; }
    portainer(){
        sudo docker run -d -p 9000:9000 -p 8000:8000 \
            -v /var/run/docker.sock:/var/run/docker.sock \
            --restart unless-stopped \
            --name portainer portainer/portainer-ce
    }
    netdata(){
        sudo docker run -d --name=netdata \
            -p 19999:19999 \
            -v netdataconfig:/etc/netdata \
            -v netdatalib:/var/lib/netdata \
            -v netdatacache:/var/cache/netdata \
            -v /etc/passwd:/host/etc/passwd:ro \
            -v /etc/group:/host/etc/group:ro \
            -v /proc:/host/proc:ro \
            -v /sys:/host/sys:ro \
            -v /etc/os-release:/host/etc/os-release:ro \
            --restart unless-stopped \
            --cap-add SYS_PTRACE \
            --security-opt apparmor=unconfined \
            netdata/netdata
    }
    nps(){
        read -p "prepare ~/nps/conf first! or you can't continue" xxx
        sudo docker run -d --name nps --net=host \
            -v ~/nps/conf:/conf \
            ffdfgdfg/nps
    }
    funcs=(base change_source portainer netdata nps)
    exec_choice ${funcs[*]}

}
GIT(){
    ssh-keygen -t rsa -C "2756456886@qq.com"
    cat ~/.ssh/id_rsa.pub
    read -p "please copy the key & goto https://github.com/settings/ssh/new"
    git config --global user.email "2756456886@qq.com"
    git config --global user.name "you-bowen"
}
Desktop(){
    echo "installing vscode..."
    echo "sudo dpkg -i <code.deb>"
    
    echo "installing FiraCode"
    sudo apt install fonts-firacode
}
zsh(){
    ohmyzsh(){
        echo "installing zsh..."
        markDone "ohmyzsh"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    }
    plugins(){
        repos_dir="$HOME/.oh-my-zsh/custom/plugins/"
        # plugins: zsh-autosuggestions; zsh-syntax-highlighting; autojump
        clone -d "zsh-autosuggestions" "$repos_dir" 
        clone -d "zsh-syntax-highlighting" "$repos_dir"
        clone -d "autojump" "$repos_dir"
        cd "$repos_dir/autojump" && python3 install.py

        rm ~/.zshrc && ln -s $HOME/maintain/.zshrc $HOME
        echo "=====please source your .zshrc!!!======"
    }
    jumpIfDoneElseDo "ohmyzsh" ohmyzsh
    plugins
    echo "please run 'source ~/.zshrc'"
}
NVIM(){ curl -sLf https://spacevim.org/install.sh | bash; }
mac_essencial(){
    echo "make sure you have brew installed on your mac!"
    # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install curl wget neofetch git
    brew install --cask docker

}
funcs=(base ctf docker GIT Desktop zsh NVIM)
exec_choice ${funcs[*]}