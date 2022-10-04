#!/usr/bin/env python3
def solution(A):
    ab = set(range(1,abs(max(A))+2)).difference(set(A))
    return min(ab)



print(solution([1,3,6,4,1,2])) #should print 5
print(solution([1,2,3])) #should print 4 
print(solution([-1,-3])) #should print 1
print(solution([-10,-3])) #should print 1