# powershell env setup

## scoop setup

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser 
irm get.scoop.sh | iex
```

## powershell setup

```powershell
# install some package
scoop install curl sudo jq
scoop install neovim gcc
# it's recommanded to install oh-my-posh with github
scoop install https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/oh-my-posh.json
scoop install fzf
```

```powershell
Install-Module posh-git -Scope CurrentUser -Force
Install-Module -Name Terminal-Icons -Repository PSGallery -Force
Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
Install-Module -Name Z -Force
Install-Module -Name PSFzf -Scope CurrentUser -Force
```

