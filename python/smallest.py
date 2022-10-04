#!/usr/bin/env python3

def solution(A):    
    max_number=max(A)

    if max_number<0:
        return 1

    set_A=set(A)
    set_B=set(range(1,max_number+1))
    set_D=set_B-set_A

    if len(set_D)==0:
        return max_number+1
    else:
        return min(set_D)




print(solution([1,3,6,4,1,2])) #should print 5
print(solution([1,2,3])) #should print 4 
print(solution([-1,-3])) #should print 1
print(solution([-10,-3])) #should print 1