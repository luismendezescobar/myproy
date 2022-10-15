#!/usr/bin/env python3

def contador(row,col):
    global B
    total_minas=0

    try:       
        if A[row][col]==1:
            total_minas+=1
    except Exception:
        pass
    try:
        if(row-1>=0):
            if A[row-1][col]==1:
                total_minas+=1            
    except Exception:
        pass
    try:
        if(row-1>=0):                    
            if A[row-1][col+1]==1:            
                total_minas+=1        
    except Exception:
        pass
    try:
        if A[row][col+1]==1:
            total_minas+=1            
    except Exception:
        pass
    try:
        if A[row+1][col+1]==1:
            total_minas+=1            
    except Exception:
        pass                
    try:
        if A[row+1][col]==1:
            total_minas+=1            
    except Exception:
        pass
    try:
        if (col-1>=0):
            if A[row+1][col-1]==1:
                total_minas+=1                
    except Exception:
        pass    
    try:
        if(col-1>=0):
            if A[row][col-1]==1:                
                total_minas+=1                
    except Exception:
        pass
    try:
        if(col-1>=0 and row-1>=0):
            if A[row-1][col-1]==1:
                total_minas+=1                
    except Exception:
        pass

    B[row][col]=total_minas


def solution(A,rows,cols):
       
    for row in range(rows):        
        for col in range(cols):
            contador(row,col)        
    
    return(B)


A=[]
B=[]

rows=int(input("Introduzca los renglones:"))
cols=int(input("Introduzca las columnas:"))
A = [[0 for j in range(cols)] for i in range(rows)]
B = [[0 for j in range(cols)] for i in range(rows)]
line=[]
for r in range(rows):
    for c in range(cols):
        A[r][c]=int(input(f"Introduzcavalor:{r},{c}:"))


print(solution(A,rows,cols))


