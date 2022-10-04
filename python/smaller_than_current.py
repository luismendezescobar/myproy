#!/usr/bin/env python3
'''
def solution(nums):
    outlist=[]
    for num in nums:
        count=0
        for num2 in nums:
            if num2<num:
                count+=1

        outlist.append(count)
    return outlist

print(solution([8,1,2,2,3]))
print(solution([6,5,4,8]))
print(solution([7,7,7,7]))

'''


def solution(nums):
    sorted_nums=sorted(nums,reverse=True)
    print(sorted_nums)
    smaller_count={}

    for i in range(len(sorted_nums)-1):
        curr_num=sorted_nums[i]
        next_num=sorted_nums[i+1]
        if next_num < curr_num:
            remaining_values=len(sorted_nums)-(i+1)
            smaller_count[curr_num]=remaining_values

        
    smaller_count[sorted_nums[-1]]=0
    print(smaller_count)

    output=[]
    for num in nums:
        output.append(smaller_count[num])
    
    return output

print(solution([8,1,2,2,3]))