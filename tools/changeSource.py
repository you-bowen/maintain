#!/usr/local/bin/python3
import click
import pyperclip

data = {
    "pip": {
        "upgrade": "pip install -U [pkg]",
        "en": "pip install -i ",
        "cn": "pip install -i []",
        "set": "pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple",
    }
}


@click.command()
def pip():
