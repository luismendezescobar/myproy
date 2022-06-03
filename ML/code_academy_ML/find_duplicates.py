some_list=['a','b','c','b','d','m','n','n']
duplicated=[]
for i in range(len(some_list)):
  value_to_search=some_list[i]
  for j in range(len(some_list)):
    if i==j:
      continue
    elif  value_to_search==some_list[j]:
      if value_to_search not in duplicated:
        duplicated.append(value_to_search)


print(duplicated)
  
duplicates={}
for i,char in enumerate(some_list):
  print(i,char)
  if some_list.count(char)>1:
      duplicates[i]=char


print(duplicates)