#!/usr/bin/env python3

class bacterias:
    def __init__(self,B):
        self.B=B
    
    def calculate(self):
        count=0
        my_dict={}
        for i in range(len(self.B)):
            for j in range(1,len(self.B[i])):
                if(self.B[i][j] in my_dict ):
                    my_dict[self.B[i][j]]+=1
                else:
                    my_dict[self.B[i][j]]=1
        
        new_val = max(my_dict, key= lambda x: my_dict[x])
        print("maximum value from dictionary:",new_val)
        


num_bacterias,num_soldados=input().split()

num_bacterias=int(num_bacterias)
num_soldados=int(num_soldados)

B = [[0 for j in range(8)] for i in range(num_bacterias)]

for i in range(num_bacterias):
    row=input()
    #row_list=row.
    row_list_numeric=[int(x) for x in row if x!=' ']
    B[i]=row_list_numeric


my_bac=bacterias(B)

my_bac.calculate()

    
    