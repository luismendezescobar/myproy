#!/usr/bin/env python3
'''
def values_that_are_keys(my_dictionary):
  list=[]
  for value in my_dictionary.values():
    for key in my_dictionary.keys():
      if value==key:
        list.append(value)
        break
  
  return list




# Uncomment these function calls to test your  function:
print(values_that_are_keys({1:100, 2:1, 3:4, 4:10}))
# should print [1, 4]
print(values_that_are_keys({"a":"apple", "b":"a", "c":100}))
# should print ["a"]
'''
'''
class Node:
  def __init__(self, value, link_node=None):
    self.value = value
    self.link_node = link_node
    
  def set_link_node(self, link_node):
    self.link_node = link_node
    
  def get_link_node(self):
    return self.link_node
  
  def get_value(self):
    return self.value

# Add your code below:
yacko=Node("likes to yak")
wacko=Node("has a penchant for hoarding snacks")
dot=Node("enjoys spending time in movie lots")

yacko.set_link_node(dot)
dot.set_link_node(wacko)
print(dot)
'''

# We'll be using our Node class
'''
class Node:
  def __init__(self, value, next_node=None):
    self.value = value
    self.next_node = next_node
    
  def get_value(self):
    return self.value
  
  def get_next_node(self):
    return self.next_node
  
  def set_next_node(self, next_node):
    self.next_node = next_node

# Create your LinkedList class below:
class LinkedList:
  def __init__(self,value=None):
    self.head_node=Node(value)
  def get_head_node(self):
    return self.head_node
  
  def insert_beginning(self,new_value):
    new_node=Node(new_value)
    new_node.set_next_node(self.head_node)
    self.head_node=new_node
   
  def stringify_list(self):
    string_list = ""
    current_node = self.get_head_node()
    while current_node:
      if current_node.get_value() != None:
        string_list += str(current_node.get_value()) + "\n"
      current_node = current_node.get_next_node()
    return string_list
  
  def remove_node(self, value_to_remove):
    current_node = self.get_head_node()
    if current_node.get_value() == value_to_remove:
      self.head_node = current_node.get_next_node()
    else:
      while current_node:
        next_node = current_node.get_next_node()
        if next_node.get_value() == value_to_remove:
          current_node.set_next_node(next_node.get_next_node())
          current_node = None
        else:
          current_node = next_node



ll=LinkedList(5)
#print(ll.get_head_node().get_value())
#print(ll.get_head_node().get_next_node())
ll.insert_beginning(70)
ll.insert_beginning(5675)
ll.insert_beginning(90)

#print(ll.stringify_list())

ll.remove_node(70)
ll.remove_node(5675)
ll.remove_node(5)
ll.remove_node(90)
print(ll.stringify_list())
'''

'''
otherset={1,4,7,7,3}
#print(thisset)
#print(otherset)

otherset2=set(range(1,10))
#print(otherset2)
A=[1,3,6,4,1,2,8,10]
A=[1,2,3]
m=max(A)
print(m)

A=set(A)
print(A)
B=set(range(1,m+1))
print(B)
D=B-A

if len(D)==0:
  print(m+1)
else:
  print(D)
  print(min(D))

'''
'''
def solution(A):
    #ab = set(range(1,abs(max(A))+2)).difference(set(A))    
    #return min(ab)

    print(set(range(1,abs(max(A))+2)))
    print(set(A))
    print(set(range(1,abs(max(A))+2)).difference(set(A)))






solution([1,3,6,4,1,2])

solution([-1,-3])

'''
str="abba"
for i in range(len(str) // 2):
  print(i)









