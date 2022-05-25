#!/usr/local/bin/python3
"""
全面的换源脚本, 开发中
"""
import os
import sys

options = [
    "pip",
    "pip3",
    "npm",
    "yarn",
    "brew",
    "apt",
    "conda"
]

if len(sys.argv) != 2 or sys.argv[1] in ["-h", "--help"]:
    print(f"Usage: chs <package_name>")

opt = sys.argv[1]
if opt not in options:
    print(f"{opt} is not supported")
    print("supported options: ", options)
    sys.exit(1)

cn = False

class Software:
    def __init__(self, name):
        self.name = name
        self.source = ""
        self.source_cn = ""
    
    def getCurrSource(self):
        pass


sources = {
    "pip": {
        "source_cn": "https://pypi.tuna.tsinghua.edu.cn/simple/", 
        "source": "https://pypi.org/simple",
        "get": "pip config get global.index-url"
    },

    
}
if opt == "pip" or opt == "pip3":
    opt = "pip"


