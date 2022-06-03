class Student:
  def __init__(self,name,year):
    self.name=name
    self.year=year
    self.grades=[]
  def add_grade(self,grade):
    if type(grade)==Grade:
      self.grades.append(grade)
  def get_average(self):
    cont=0
    average=0
    for i in self.grades:
      average+=i.score
      cont+=1
    return average/cont


class Grade:
  minimum_passing=65
  def __init__(self,score):
    self.score=score
  def is_passing(self):
    if self.score>self.minimum_passing:
      return f"{self.score} is a passing score"
    else:
      return f"{self.score} is NOT passing score"




roger=Student("Roger van der Weyden",10)
sandro=Student("Sandro Botticelli",12)
pieter=Student("Pieter Bruegel the Elder",8)
pieter_grade=Grade(100)
pieter.add_grade(pieter_grade)
pieter_grade=Grade(80)
pieter.add_grade(pieter_grade)
print(pieter_grade.is_passing())
print(f"pieter average is {pieter.get_average()}")
