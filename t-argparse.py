import argparse
parser = argparse.ArgumentParser(
    description="make your clone EASY!",
    usage="clone [-*] [repo] [dest]"
)
# more usage goto: https://docs.python.org/zh-cn/3/library/argparse.html
parser.add_argument('-s','--self', action="store_true", help="opt 无需指名")
parser.add_argument('-s','--self', help="opt 需要指名")
parser.add_argument('a', type=str,help="esse 占>=1个位置",nargs='+')
parser.add_argument('d', type=str,help="esse 占>=0个位置",nargs='*')
parser.add_argument("b", type=str,help="esse 占一个位置")
parser.add_argument("c", type=str,help="opt 占<=1个位置",nargs='?',default=None)
# 其他有用的参数：default action nargs type
args = parser.parse_args()

print(args)