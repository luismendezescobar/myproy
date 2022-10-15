#!/usr/bin/env python3




def solution(pool, favorites):
    indexes=[x for x in range(len(pool))]
    
    #sums={}
    #for x in range(len(pool)):
    #    sums[x]=[]    

    
    dict_pos=0
    end=len(pool)
    base=0
    next=0
    big_number=10000

    for myfav in favorites:
        big_number=10000
        for i in range(end):
            for j in range(i+1,end):
                suma=pool[i]+pool[j]                
                if (abs(suma-myfav)<=big_number):
                    n=i+1
                    m=j+1
                    big_number=abs(suma-myfav)
                    result=suma

        print(n,m,result)


        '''
        if i<(end-1):
            print(pool[base],pool[next+1])
            sums[dict_pos].append(pool[base]+pool[next+1])
            next+=1
        '''
            
    
    



#solution([3,12,17,33,34], [1,51,30])
solution([1,2,3], [4,5,6])