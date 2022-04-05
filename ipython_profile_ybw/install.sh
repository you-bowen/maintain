suffix="ybw" # 要和文件夹(ipython_profile_ybw)的后缀保持一致
profile_root="$HOME/.ipython/profile_$suffix"
startup="$HOME/.ipython/profile_$suffix/startup"
root="$HOME/maintain/ipython_profile_$suffix"
mkdir $profile_root
mkdir $startup
ln -s "$root/ipython_config.py" "$profile_root/" 
ln -s "$root/rc.py" "$startup/"
echo "over." 
