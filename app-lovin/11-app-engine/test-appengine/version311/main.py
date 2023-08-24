from flask import Flask

app = Flask(__name__)


@app.route('/')
@app.route('/home')
def home():
    return f'''        
    <h1>Hello, python version 3.11</h1> 
    <h1>Release number 1.0.4</h1>
    <h1>This a new version with github actions part 2</h1>     
    <a href=/article/this-is-an-article>Go to the article page</a>   

    
    <h1></h1>

    <a href=/reporter/1>Go to the reporter page #1</a>       
    '''


@app.route('/reporter/<int:reporter_id>')
def reporter(reporter_id):
    return f'''
     <h2>Reporter {reporter_id} Bio</h2>
     <h3>Reporter number 1 was born in Mexico<h3>     
     <a href="/">Return to home page</a>
    '''
@app.route('/article/<article_name>')
def article(article_name):
  return f'''
  <h2>{article_name.replace('-', ' ').title()}</h2>
  <h4> Article about how to write a page in using flask</h4>
  <a href="/">Return back to home page</a>
  '''



if __name__ == "__main__":
  app.run(host='0.0.0.0',port=8080)  
