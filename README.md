
This app is a Hangman Game. 
An important feature of our version of hangman is that instead of just playing one word at a time, you continue to play more and more words until you fail to guess one of them, and therefore die. A "game" of hangman then is one round of continuous words until you either exit or die. You get an accumulated score based on the total of the point values of each word that you correctly guessed in that game.

There are four models:
* Player, who has_many:
* Games, which each have many:
* Words, through:
* Gamewords, a joiner for the previous two. 

A word technically "has_many:" Games, but we don't care about that because there is never a time where we care about checking which games a given word was used in. 

The hangman.rb file will take care of all of the running and menus and CLI interaction. 

There is also a file hangman_picture.rb which is basically just an array of the different ASCII hangman doodle images, and a method to return the appropriate doodle for your stage in the game.

A Word object has just a string "the_word" of the actual word itself, as well as a float point-value, which is arbitrarily based on the difficulty of guessing that word. 

Through GameWords, a Game instance can access all the words used in that game. GameWords serves no other purpose.

A Player instance has methods for getting their top score, all their past scores, deleting one or all of their past scores, and viewing the number of games they have played so far.

The Game class is where nearly all of the non-CLI magic happens. The Game class can give you the leaderboard of the all-time high scores in our database. A Game instance can calculate its score, retrieve a new word object, check a one-letter-guess or a whole-word-guess against the current word, keep track of any hints used, generate hints, create and update the concealed word (with letters obscured), keep track of what you have guessed already, and check if you have completed the whole word. 

Then the Hangman.rb file adds all of the actual interaction features. Here, you can log in or sign up, start a new game, update your username, view scores, and delete scores. Inside of a game, you can guess letters, words, and choose to receive hints. As you do these things, the terminal is updated with sounds depending on the result of your guess, and an updated score, word, and doodle. 

Some future developments could be:
  * to allow a player to continue a game that they exited from and didn't die in yet.
  * to award bonus points for guessing a whole word "early" (while there is more than one letter left)
  * add more words
  * have words calculate their own point value based on pre-set criteria for assessing their own difficulty
