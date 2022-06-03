letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
points = [1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 4, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10]

letter_to_points={key:value for key, value in zip(letters,points)}
letter_to_points[""] = 0
player_to_words={
  "player1":["BLUE","TENNIS","EXIT"],
  "wordNerd":["EARTH","EYES","MACHINE"],
  "Lexi Con":["ERASER","BELLY","HUSKY"],
  "Prof Reader":["ZAP","COMA","PERIOD"],
}
player_to_points={}

def score_word(word):
  point_total=0
  for letter in word:
    point_total+=letter_to_points.get(letter,0)
  return point_total


def play_word(player_name,new_word):
  new_word=new_word.upper()
  words=player_to_words[player_name]
  words.append(new_word)
  player_to_words[player_name]=words

def update_point_totals(): 
  for player, words in player_to_words.items():
    player_points=0
    for word in words:
      player_points+=score_word(word)
    player_to_points[player]=player_points
  print(player_to_points)

def get_winner():
  winner={}
  major=0
  morethan1=False
  for player, points in player_to_points.items():
    if points>major:
      winner={player:points}
      major=points
    elif points==major:
      morethan1=True
      winner[player]=points

  
  return winner,morethan1


update_point_totals()
play_word('Lexi Con','hello')
play_word('wordNerd','perro')
print(player_to_words)
update_point_totals()
winner,morethan1=get_winner()
if morethan1:
  print(f"{winner} are the Winners, Congratulations to you!!")
else:
  print(f"{winner} is the Winner, Congratulations")
