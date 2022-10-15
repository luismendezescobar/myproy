#!/usr/bin/env python3

def solution(x,y):
    x_coordinates=['a','b','c','d','e','f','g','h']
    for index in range(len(x_coordinates)):
        if (x_coordinates[index]==x):
            pos_x=index
    
    A=[]
    A = [[0 for j in range(8)] for i in range(8)]

    for i in range(8):
        if i%2==0:
            A[i]=[1,0,1,0,1,0,1,0]

        else:
            A[i]=[0,1,0,1,0,1,0,1]

    if A[pos_x][y-1]==0:
        print("BLANCO")
    else:
        print("NEGRO")







solution('h',8)
