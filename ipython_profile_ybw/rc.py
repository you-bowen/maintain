import sys
import os
import ctypes as c
import binascii as ba
import IPython
import base64
import requests as r
from collections import *
import math
import re
j = os.path.join
py = IPython.get_ipython()
py.Completer.use_jedi = False

def matrix():
    """
    create a matrix, which have m_rows n_cols
    """
    print("[[0]*(n) for _ in range(m)]")