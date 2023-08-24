from flask import Flask

app = Flask(__name__)


@app.route('/')
def home():
    return f'''    
    <h1>Hello, World!</h1> 
    <h1>Ignore this version. It's only to have the default created</h1> 

    '''

if __name__=='__main__':
    app.run(host='127.0.0.1',port=8080,debug=True)