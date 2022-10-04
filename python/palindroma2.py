#!/usr/bin/env python3
def findString(n, k):
 
    # Initialize result with first k
    # Latin letters
    res = ""
    for i in range(k):
        res = res + chr(ord('a') + i)
 
    # Fill remaining n-k letters by
    # repeating k letters again and again.
    count = 0
    for i in range(n - k) :
        res = res + chr(ord('a') + count)
        count += 1
        if (count == k):
            count = 0;
     
    return res
 

n = 8
k = 3
print(findString(n, k))