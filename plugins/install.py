import os
cwd = __file__[:__file__.rindex("/")]
print(cwd)
root = f"{os.getenv('HOME')}/.oh-my-zsh/plugins"
for file in os.listdir(cwd):
    if not file.endswith(".plugin.zsh"):
        continue
    plugin_name = file.split(".")[0]
    if os.path.exists(f"{root}/{plugin_name}"):
        print(f"dir-`{plugin_name}` exists") # 有可能你写的插件和已经有的插件重名了
    else:
        os.mkdir(f"{root}/{plugin_name}")
        os.system(f"ln -s {cwd}/{file} {root}/{plugin_name}/{file}")
