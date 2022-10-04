#!/usr/bin/env python3

import re


def solution(a):    
    no_space=a.replace(' ','')
    reversed=no_space[::-1]
    #print(reversed)
    if no_space==reversed:
        return True
    else:
        return False







print(solution("abba"))
print(solution("taco cat"))
print(solution("racecar"))
print(solution("able was I ere I saw elba"))

#print(solution("abba")) #should print [3,2,2,4,2]
