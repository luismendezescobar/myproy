#!/usr/bin/env python3
from collections import Counter
def maxrep(a):
    if(len(a)==0):
        return 0
    c = Counter(a)
    return c.most_common(1)[0][1]
    
def solution(n, a):
    ll=[[]]# split to multiple lists
    b = 0 # index for the next sublist
    for i in range(0,len(a)):
        if (a[i]== n+1): # break
            b=b+1
            ll.append([])
        else:
            ll[b].append(a[i])

    c = [] # list of max repeat counters
    for l in ll:
        c.append(maxrep(l))

    s = sum(c[:-1])
    r = [s]* n
    if (c[-1]==0):
        return r
    else:
        # get index of last (n+1)
        if(n+1 in a):
            lin = len(a) - a[::-1].index(n+1)
        else:
            lin =0
        
        for v in a[lin:]:
            r[v-1] = r[v-1]+1
        return r





print(solution(6,[3,4,4,6,1,4,4])) #should print [3,2,2,4,2]
