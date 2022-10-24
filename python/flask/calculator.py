from flask import Flask

app = Flask(__name__)


@app.route('/')
def welcome():
  return "Welcome to the Codecademy Calculator!"

num1 = int(input('Enter your first number: '))
num2 = int(input('Enter your second number: '))

@app.route('/division')
def division():
  return "Now dividing " + str(num1) + " and " + str(num2) + "! The result is: {result}".format(result=str(num1/num2))

@app.route('/multiplication')
def multiplication():
  return "Now multiplying " + str(num1) + " and " + str(num2) + "! The result is: {result}".format(result=str(num1*num2))

app.run()