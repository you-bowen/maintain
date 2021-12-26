import json
import sys
import argparse

# TODO: -c option --create value if not exists
# TODO: -d option --delete value if exists
# TODO: identify if value is a `string` or `dumped dict`
    # if only one argument, it's a dumped dict and we should take k,v from it and add to root
# TODO: -i option --insert value like sed
# TODO: -D option --debug mode

parser = argparse.ArgumentParser(
    description="modify json file easier",
)
parser.add_argument('-c','--create',  action="store_true", help="create items")
parser.add_argument('-d','--delete',  action="store_true", help="delete items")
parser.add_argument('-f','--file',   type=str, help="target file")
parser.add_argument("targets", help="递归的targets", type=str, nargs='*')
args = parser.parse_args()

def pps(s):
    """
    judge input is a dumped dict or a string
    """
    try:
        return json.loads(s)
    except:
        return s
    
def build(targets,i,built):
    # build(['a','b','c','d','{"c":1}'], 1, {})
    # {'a': {'b': {'c': {'d': {'c': 1}}}}}

    if i == len(targets):
        return built
    if i == 1:
        return build(targets, i+1, {targets[-i-1]:pps(targets[-i])})
    return build(targets, i+1, {targets[-i-1]:built})

targets = args.targets
print(targets)

data = {"a":{"b":{"c":1}, "bb":12},"aa":['qwq']}

if 1: ### modify mode and create mode
    
    # eg: a b d 2
    # eg: a b c 2
    # 找到第一个分歧点，组建成字典，对字典进行遍历，把k和v插进去
    # 找分歧点的意义在于不进行过量的更改
    ptr = data
    for i, k in enumerate(targets):
        # print(k)
        if k in ptr.keys():
            f_ptr = ptr     # father ptr
            ptr = ptr[k]    # ptr
            if not isinstance(ptr, dict):
                ptr = f_ptr # rollback
                break
        else:
            break
    # i = 2 in the example case, build the dict
    built = build(targets[i:],1 ,{})
    for k, v in built.items():
        if args.create or k in ptr.keys():
            ptr[k] = v
        else:
            print("Error: key not exists, if u want to create it, use -c option")

print(data)

