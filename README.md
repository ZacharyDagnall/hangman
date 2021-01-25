IDK if README is the appropriate name for this, but might be helpful for organization. 

######
## SCORE_RECORD
## relations & attributes
A ScoreRecord belongs_to one Player.
 * player_id (int)
## methods
ScoreRecord#top_score # tells one instance's top score
ScoreRecord.high_scores # tells the top 5 (?) scores of all time of all score records (we could also call it "Leader Board")
ScoreRecord#delete_score(score_from_record) #deletes a score from the record, for embarassment guarding
ScoreRecord#delete_record                   #deletes an entire score record


######
## PLAYER
## relations & attributes
a Player belongs_to one ScoreRecord
a Player has_many Games
 * name (str)
 * score_record_id (int)
## methods


######
## GAME 
## relations & attributes
a Game belongs_to one Player
a Game has_many Words
 * current_score (int)  #accumulated up to this point, initialized to 0 for a new game
 * current Word (Word object) (word_id? (int))
## methods




######
## WORD
## relations & attributes
A Word has_many Hints
 * the_word (string)
 * point_value (int)
## methods


######
## HINT
## relations & attributes
a Hint belongs_to a Word
 * the_hint (str)
 * point_deduction (int) #player earns less points when they use a hint
## methods