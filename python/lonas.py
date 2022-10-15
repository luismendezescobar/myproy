#!/usr/bin/env python3

from itertools import combinations

def solution(k,postes_pool):
    max_num=1000000        
    postes_pool_sorted=sorted(postes_pool)
    #min_diff=0
    initial_diff=0
    
    for i in range(len(postes_pool_sorted)-k):
        initial_diff=postes_pool_sorted[i+k-1]-postes_pool_sorted[i]

        if(initial_diff<max_num):
            #min_diff=initial_diff
            max_num=initial_diff

    print(max_num)




k=int(input("introduzca el # de postes a usar:"))
n=int(input("introduzca el # de postes en el pool:"))

print("Introduzca el pool de medidas de postes:")
postes_pool=[]
for i in range(n):
    postes_pool.append(int(input()))


solution(k,postes_pool)
#solution(3,[100,20,40,33,65,200,77,178,135,47])
