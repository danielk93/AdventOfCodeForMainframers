# python3 day15solution.py
T=open('day15input.txt').read().strip().split(',')
h,d=lambda t:__import__('functools').reduce(lambda a,b:(17*(a+ord(b)))%256,t,0),{}
for t in T:
    lb,fc=t[:t.find('=')],int(t[-1]) if '=' in t else None
    d.setdefault((box:=h(lb)),{}).update({lb:fc})
    d[box].pop(lb if not fc else None, None)
print(sum(map(h,T)))