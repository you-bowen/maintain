import sys
import os
from pwn import *
import ctypes as c
import binascii as ba
import IPython
py = IPython.get_ipython()
py.Completer.use_jedi = False
