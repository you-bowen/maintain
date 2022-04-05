import os
root = f"{os.getenv('HOME')}/Library/Mobile Documents/iCloud~md~obsidian/Documents"
if not os.getcwd().startswith(root):
    print("you are not in the obsidian directory")
    exit()

