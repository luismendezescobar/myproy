#!/usr/bin/env python3
'''
def solution(n):
    

    return dif1+dif2+dif3
    
'''
'''
def fibonacci(n):
    sequence = []
    if n == 1:
        sequence = [1]
    else:
        sequence = [1,2]
        for i in range(1, n-1):
            sequence.append(sequence[i-1] + sequence[i])
    return max(sequence)
'''

def fibonacci(n):
    n+=1
    if n > 1:
        return fibonacci(n-1) + [(1.618033988749895**n/2.23606797749979 + 0.2) // 1]
    else:
        return [1]




print(fibonacci(1))
print(fibonacci(4))
print(fibonacci(5))
print(fibonacci(6))

#print(4)

