#!/usr/bin/env python3

def solution(largo,sube,resbala):

    minutes=0
    progreso=0

    while progreso<largo:
        progreso+=sube
        minutes+=1
        if progreso>=largo:
            break
        progreso-=resbala
        minutes+=1

    return minutes


print(solution(10,2,1))
print(solution(20,3,1))
