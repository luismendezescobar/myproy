
def merge_sorted_lists(a, b):
    
   both_list=a+b
  # result_sorted=sorted(both_list)
   
   #for i in range(len(both_list)):
   #lower=both
   print(both_list)
   

   for i in range(len(both_list)):
    for j in range(i+1,len(both_list)):
        if both_list[i]>both_list[j]:
            temp=both_list[j]
            both_list[j]=both_list[i]
            both_list[i]=temp

  
   
   
   sorted_list=set(both_list)
   
   
   
   return both_list,sorted_list






a = [1,6,9,10]
b = [5,6,7]

print(merge_sorted_lists(a,b))

