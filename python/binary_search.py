#!/usr/bin/env python3

def solution(nums,target):
    start=0
    end=len(nums)-1
    while start<= end:        
        mid=(start+end)//2
        num=nums[mid]
        if target == num:
            return mid
        if target> num:
            start =mid+1        
        if target< num:
            end = mid-1
    
    return -1

        

print(solution([-1,0,3,5,9,12],-1))








