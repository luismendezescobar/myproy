#!/usr/bin/env python3


def solution(A,B):    
    A_1=""
    B_1=""
    A_2=""
    B_2=""

    for item in A :
        if item=='6':
            A_1+='5'
        else:
            A_1+=item

    
    for item in B :
        if item=='6':
            B_1+='5'
        else:
            B_1+=item

    for item in A :
        if item=='5':
            A_2+='6'
        else:
            A_2+=item

    for item in B :
        if item=='5':
            B_2+='6'
        else:
            B_2+=item


    sum1=int(A_1)+int(B_1)
    sum2=int(A_2)+int(B_2)

    if(sum1>sum2):
        return sum2, sum1
    else:
        return sum1,sum2



A,B=input().split()

print(solution(A,B))



