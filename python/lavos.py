#!/usr/bin/env python3
esporas=[]
esporas = [0 for i in range(4000000)] 
total=0
def reproducir(pos):
    global esporas
    global total
    cant=esporas[pos]
    total+=cant
    #3 esporas 100,000
    t1=pos+100000
    esporas[t1]+=cant*3
    #7 esporas 500,000
    t2=pos+500000
    esporas[t2]+=cant*7




def solution(t):
    global total    
    esporas[0]=1
    for i in range(t+1):
        reproducir(i)

    return total




print(solution(200000))

