from flask import Flask
from helper import pets

app = Flask(__name__)

@app.route('/blue/something')
def index():
  return f'''
  <body style="background-color:powderblue;">
  <h1>Adopt a Pet!</h1>
  <p>Browse through the links below to find your new furry friend:</p>
  <ul>
    <li><a href="/animals/dogs">Dogs</a></li>
    <li><a href="/animals/cats">Cats</a></li>
    <li><a href="/animals/rabbits">Rabbits</a></li>
  </ul>
  </body>
  '''
@app.route('/animals/<pet_type>')
def animals(pet_type):
  html=f"<h1>List of {pet_type}</h1>"    
  for animal in pets.keys():
    if animal==pet_type:
      for idx,item in enumerate(pets[animal]):
        myname=item['name']        
        html+=f'<li><a href="/animals/{pet_type}/{idx}">{myname}</a></li>'
    
  return f'<ul>{html}</lu>'

@app.route('/animals/<pet_type>/<int:pet_id>')
def pet(pet_type,pet_id):  
  for animal in pets.keys():
    if animal==pet_type:
      for i in range(len(pets[animal])):
        if i==pet_id:
          pet=pets[animal][i]
  pet_name=pet['name']
  pet_url=pet['url']
  pet_desc=pet['description']
  pet_breed=pet['breed']
  pet_age=pet['age']

  return f'''  
  <h1>{pet_name}</h1>
  <img src={pet_url} />
  <p>{pet_desc}</p>
  <ul>
    <li>{pet_breed}</li>
    <li>{pet_age}</li>
  </ul>

  '''

if __name__ == "__main__":
  app.run(host='0.0.0.0',port=80)  

