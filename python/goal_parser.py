#!/usr/bin/env python3

def solution(list):
    list=list.replace("()","o")
    list=list.replace("(al)","al")
    return list
    
    


#### TESTS SHOULD ALL BE TRUE ####

print(solution("G()(al)"))
print(solution("G()()()()(al)"))
