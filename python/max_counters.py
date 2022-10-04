#!/usr/bin/env python3

def solution(n,a):    
    #my_list=[0 for i in range(0,n)]    
    my_list=[0]*n
    for item in a:
        if item>n:
            max_counter=max(my_list)
            #my_list=[max_counter for i in range(0,n)]            
            my_list=[max_counter]*n
        else:
            my_list[item-1]+=1

    return my_list







print(solution(6,[3,4,4,6,1,4,4])) #should print [3,2,2,4,2]
