#!/usr/bin/env python3
from math import factorial

def solution(H,W):
    return int((factorial(H+W)/(factorial(H)*factorial(W))))



H,W=input().split()

print(solution(int(H),int(W)))



