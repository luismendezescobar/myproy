#!/usr/bin/env python3

def solution(nums,target):
    output1=[]
    output2=[]
    for i in range(len(nums)):
        if nums[i]==target:
            output1.append(i)
    
    
    if len(output1)>2:
        output2.append(output1[0])
        output2.append(output1[len(output1)-1])
        return output2
    else:
        return output1






        

print(solution([2,4,5,5,5,5,5,7,9,9],3))


