#!/usr/bin/env python3
      
def solution(n, k):    
    pal=['@' for x in range(n)]
    my_key_letters="abcdefghijklmnopqrstuvwxyz"
    pool=my_key_letters[:k]
    
    if n%2==0:
        if n/2>=k:            
            return convert_palin(pal,pool)
    else:        
        if (n//2)+1>=k:
            return convert_palin(pal,pool)


    print("invalid n and k values, try with a k valuer lower")
    return None
    


def convert_palin(pal,pool):
    pool_index=0
    mid=(len(pal))//2
    
    for i in range(mid):
        if pool_index==len(pool):
            pool_index=0
        pal[i]=pool[pool_index]                
        pool_index+=1
    
    pool_index=0
    for i in range(len(pal)-1,mid-1,-1):                                
        if pool_index==len(pool):
            pool_index=0
        pal[i]=pool[pool_index]                
        pool_index+=1
    
    return "".join(pal)             



n=50
k=26


print (solution(n, k))