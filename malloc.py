import requests as r
from lxml import etree
from collections import OrderedDict as od
from pwn import *
from time import time
context.log_level = 'debug'
target_url = "https://sourceware.org/git/?p=glibc.git;a=tags"
debug("request start..."); st=time()
resp = r.get(target_url).content; ed=time()
debug(f"request ended. consume time={ed-st}")
html = etree.HTML(resp)
debug(f"etree build ended. time={time()-ed}")

all_ele = html.xpath(f"/html/body/table/tr")
total = len(all_ele)


data = od({})
for i in range(1,total):
   ele = html.xpath(f"/html/body/table/tr[{i}]/td[2]/a")[0]
   if len(ele.text) == len("glibc-2.23"):
      urls = {
         "home" :"https://sourceware.org"+ele.attrib['href'],
         "malloc.c" : f"https://sourceware.org/git/?p=glibc.git;a=blob_plain;f=malloc/malloc.c;hb={ele.attrib['href'].split('h=')[1]}"
      }
      data[ele.text] = urls
   if ele.text == "glibc-2.23":
      break
info(f"versions latest: {list(data.keys())[0]}")
ver = input("which version of malloc you want to download? (eg:2.23):").strip()


if f"glibc-{ver}" in list(data.keys()):
   urls = data[f"glibc-{ver}"]
   with open(f"malloc-{ver}.c","w") as f:
      content = r.get(urls["malloc.c"]).text
      f.write(content)
   success(f"downloaded malloc-{ver}.c")
   info(f"you can goto glibc-{ver}'s home for more info!")
   info(f"🏠home: {urls['home']}")
else:
   error("your input is invalid!")