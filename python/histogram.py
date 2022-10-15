#!/usr/bin/env python3
#program to calculate the water that falls into an histogram
def solution(histo):
    accum=0
    leftwall=[]
    rightwall=[]
    maximum=histo[0]
    leftwall.append(maximum)
    for i in range(1,len(histo)):
        if(histo[i]>maximum):
            maximum=histo[i]
            leftwall.append(maximum)
        else:
            leftwall.append(maximum)

    maximum=histo[-1]
    rightwall.append(maximum)b

    for i in range(len(histo)-2,-1,-1):
        if(histo[i]>maximum):            
            maximum=histo[i]
            rightwall=[maximum]+rightwall
        else:
            rightwall=[maximum]+rightwall
     

    max_left=max(leftwall)    
    begin=0
    for i in range(len(histo)):
        accum+=leftwall[i]-histo[i]        
        if(leftwall[i]==max_left): #we found the end of the leftwall maximum
            begin=i+1
            break              

    for i in range(begin,len(histo)):
        accum+=rightwall[i]-histo[i]
        #print(rightwall[i]-histo[i])


    print(f"result:{accum}")

#solution([2,0,1,3,0,4,0,1])
#solution([4,2,1,3,0,1,2])
solution([3,2,1,0,6,1,2])

