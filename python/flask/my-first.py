from flask import Flask

app = Flask(__name__)


@app.route('/')
@app.route('/home')
def home():
    return f'''    
    <h1>Hello, World!</h1> 
    <a href=/article/this-is-an-article>Go to the article page</a>   
    '''


@app.route('/reporter/<int:reporter_id>')
def reporter(reporter_id):
    return f'''
    <h2>Reporter {reporter_id} Bio</h2>
    <a href="/">Return to home page</a>
    '''
@app.route('/article/<article_name>')
def article(article_name):
  return f'''
  <h2>{article_name.replace('-', ' ').title()}</h2>
  <a href="/">Return back to home page</a>
  '''


app.run()