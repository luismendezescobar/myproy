#!/usr/bin/env python3

def solution(pair1,pair2,pair3):
    dif1=abs(pair1[1]-pair1[0])
    dif2=abs(pair2[1]-pair2[0])
    dif3=abs(pair3[1]-pair3[0])

    return dif1+dif2+dif3
    




print(solution([8,16],[4,7],[9,9]))
print(solution([8,13],[14,7],[19,16]))

