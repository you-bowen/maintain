import sys
import os
from pwn import *
import ctypes as c
import binascii as ba
import IPython
import base64
import requests as r
j = os.path.join
py = IPython.get_ipython()
py.Completer.use_jedi = False
