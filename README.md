IDK if README is the appropriate name for this, but might be helpful for organization. 



###### #########################################################
#### mysterious methods (not sure where they go)
 * leader_board (can this go in the hangman.rb file itself?? ) 

######
## PLAYER
## relations & attributes
a Player has_many Games
 * name (str)
## methods
 * list all scores (arr)
 * get top score
 * delete a score
 * delete all scores
 * change name
 


######
## GAME 
## relations & attributes
a Game belongs_to one Player
a Game has_many Words thru GameWords  # this_game.words.last gives us the current word
* player_id (int)
* is_over (boolean=false)    # lets you know if the game is over or active
## methods
 * calculate score
 *  many more, i'm sure....

######
## GAMEWORD
## relations & attributes
belongs_to: Word
belongs_to: Game
 * game_id (int)
 * word_id (int)
# no methods

######
## WORD
## relations & attributes
a Word has_many Hints
 * the_word (string)
 * point_value (int)
## methods
  * generate hints ? not sure

######
## HINT
## relations & attributes
a Hint belongs_to a Word
 * the_hint (str)
 * point_deduction (int) #player earns less points when they use a hint
 * word_id (int)
# no methods