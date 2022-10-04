#!/usr/bin/env python3
import random
import string



def solution(n, k):    
    pal=['@' for x in range(n)]
    my_key_letters="abcdefghijklmnopqrstuvwxyz"
    pool=my_key_letters[:k]
    #print(pool)
    #print(pal)

    
    if n%2==0:
        if n/2>=k:
            j=len(pal)-1
            pool_index=0
            #print(pal)
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
            
            #print(pal)                    
            return pal                      


    else:        
        if (n//2)+1>=k:
            j=len(pal)-1
            pool_index=0
            #print(pal)
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
                          
            return pal     


    print("invalid n and k values, try with a k valuer lower")
    





n=4
k=2


print (solution(n, k))