#!/usr/bin/env python3

class School:            
    def __init__(self,name,level,numberofStudents):                
        self.__name=name
        if (level=='primary'or level=='middle'or level=='high'):            
            self.__level=level
        else:
            self.__level='primary'
        
        self.__numberofStudents=numberofStudents

    def __repr__(self):
        return f'A {self.__level} school named {self.__name}  with {self.__numberofStudents} students'
     
    @property
    def level(self):   
      return self.__level

    @property
    def name(self):   
      return self.__name

    @property
    def numberofStudents(self):   
      return self.__numberofStudents
    
    @numberofStudents.setter
    def numberofStudents(self,numberofStudents):
        if(numberofStudents>0):
            self.__numberofStudents=numberofStudents


class Primary(School):
    def __init__(self,name,numberofStudents,pickupPolicy):
        super().__init__(name,"primary",numberofStudents)        
        self.__pickupPolicy=pickupPolicy
    
    @property   #this is a getter using a decorator
    def pickupPolicy(self):   
      return self.__pickupPolicy
    
    def __repr__(self):
        temp=super().__repr__()
        return temp +f'the pick policy is:{self.__pickupPolicy}'



class Middle(School):
    pass

class High(School):
    def __init__(self,name,numberofStudents,sportsTeams):
        super().__init__(name,"high",numberofStudents)   
        self.__sportsTeams=sportsTeams

    @property  #this is a getter using a decorator
    def sportsTeams(self):
        return self.__sportsTeams

    def __repr__(self):
        temp=super().__repr__()
        return temp +f'los equipos deportivos son:{self.__sportsTeams}'


myschool=School("luis","wrong",10)

print(myschool.name,myschool.level,myschool.numberofStudents)
myschool.numberofStudents=20
print(myschool.name,myschool.level,myschool.numberofStudents)
print(myschool)

myprimary=Primary('ninos heroes',100,"pass at 1 pm ct")
print(myprimary.pickupPolicy)
print(myprimary)

myhigh=High('CENCH',5000,['Basket','futball','base-basll'])
print(myhigh.sportsTeams)
print(myhigh)