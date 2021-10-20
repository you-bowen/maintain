profile_root="$HOME/.ipython/profile_pwn"
startup="$HOME/.ipython/profile_pwn/startup"
root="$HOME/maintain/ipython_profile_pwn"
mkdir $profile_root
mkdir $startup
ln -s "$root/ipython_config.py" "$profile_root/" 
ln -s "$root/rc.py" "$startup/"
echo "over." 
