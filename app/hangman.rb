class Hangman
    # here will be your CLI!
    # it is not an AR class so you need to add attr
  
    attr_reader :prompt

    def initialize
      @prompt = TTY::Prompt.new
    end


    def run
      top_menu
      puts "Thanks for playing!"
    end

    def top_menu
      continue = true
      while continue
        prompt.select("Welcome to hangman") do |menu|
          menu.choice "log in" , -> {log_in}
          menu.choice "sign up", -> {sign_up}
          menu.choice "view leaderboard", -> {puts Game.leader_board}
          menu.choice "exit", -> {continue = false}
        end
      end
    end

    def logged_in_menu(player)
      puts "Welcome #{player.username}!"
      if player.open_game?
        prompt.yes?("Continue last game?")
      end
      continue=true
      while (continue)
        player.reload
        prompt.select("MENU:") do |menu|
          menu.choice "Instructions and Rules", -> {instructions_and_rules}
          menu.choice "View your past scores", -> {puts player.view_all_scores} 
          menu.choice "View your top score", -> {puts player.top_score}
          menu.choice "View leader board", -> {puts Game.leader_board}
          menu.choice "Start new game", -> {run_game(player)}
          menu.choice "Delete a score", -> {delete_a_score(player)}
          menu.choice "Delete all scores", -> {delete_all_scores(player)}
          menu.choice "Update Username", -> {update_username(player)}
          menu.choice "View number of games played", -> {puts player.num_games_played}
          menu.choice "Log out", -> {continue=false}
        end
      end
    end

    def log_in
      usrnm = prompt.ask("What is your username?").capitalize
      player = Player.find_by(username: usrnm)
      if usrnm == "Exit"
        return 
      end
      if !player && prompt.yes?("This username doesn't exist. Would you like to sign up?")
        sign_up
      elsif player
        logged_in_menu(player)
      end
    end

    def sign_up
      usrnm = prompt.ask("What would you like your username to be?").capitalize
      while (Player.find_by(username: usrnm) && usrnm != "Exit")
        puts "This username is already taken!"
        usrnm = prompt.ask("What would you like your username to be?").capitalize
      end
      if (usrnm != "Exit")
        player = Player.create(username: usrnm)
        logged_in_menu(player)
      end
    end

    def instructions_and_rules
      puts <<~WELCOME
        Welcome to Sam and Zak's Hangman game!! Thanks for....
          h a n g i n g  out !
          with us ;)
        At any point in the game, if you type in "exit", you will be taken out of the current menu/game.
      WELCOME
      puts <<~RULES
        Here are the rules for the game:
        1. You will be provided with a random word in the form of underscores from our database of words with varying difficulty, some can be pretty tough! The amount of underscores matches the amount of letters in the word
        2. You have 10 guess to complete the word, you can guess 1 letter at a time or guess an entire word
        3. When you accumulate 10 incorrect guesses on any given word you lose and are dead! (oh nooo) Your wrong guesses reset upon receiving a new word
        4. You will not be penalized for guessing the same letter or word twice; if you guess 'a' or 'dog' once and it is wrong you will not be penalized for guessing it again
        5. If you correctly guess a letter the underscores will be updated to reflect the placement of that letter within your current word 
        6. If you correctly guess the entire word, good job! You will be given a new word to complete
        7. You will continually get new words as you get each correct until you die. Go for the high score!
        8. If you are stuck on a word and want help type "hint" (the word will never be hint) and receive a hint to help you. Beware, hints will reduce your points earned for completing that word!  
      RULES
    end

    def delete_a_score(player)
      score = prompt.ask("What score do you want to delete?").to_f
      sure = prompt.yes?("Are you 💯 ???")
      if sure
        if !player.delete_score(score)
          puts "There was no such score found."
        end
      end
    end

    def delete_all_scores(player)
      sure = prompt.yes?("You sure you wanna delete all of your scores my guy???")
      if sure
        player.delete_all_scores
      end
    end

    def update_username(player)
      usrnm = prompt.ask("What would you like your new username to be?").capitalize
      while (Player.find_by(username: usrnm) && usrnm != "exit")
        puts "This username is already taken!"
        usrnm = prompt.ask("What would you like your new username to be?").capitalize
      end
      if (usrnm != "exit")
        player.update(username: usrnm)
      end
    end

    def run_game(current_player)
      game = Game.create(player: current_player)
      dead = false
      while !dead
        dead = !run_word(game) #run word returns false when dead, true if success
      end
    end

    def run_word(game)
      game.get_word
      guess = ""
      while guess != "exit" && guess != "Exit"
        if game.guesses_remaining==0
          game.die
          puts "You are D E A D."
          puts HangmanPictures.return_pic(-1)
          puts "The word was: #{game.return_revealed_word.the_word} \n\n"
          return false
        end
        puts HangmanPictures.return_pic(game.wrong_guesses)
        game.print_concealed_word
        puts "This word is worth #{game.return_revealed_word.point_value} points."
        puts "You have #{game.guesses_remaining} guesses remaining.\n\n"
        guess = prompt.ask("What is your guess?")
        result = game.make_guess(guess)
        if game.guesses_remaining==0
          game.die
          puts "You are D E A D."
          puts HangmanPictures.return_pic(-1)
          puts "The word was: #{game.return_revealed_word.the_word} \n\n"
          return false
        end
        if result == "You've already guessed this letter!!" || result == "You've already guessed this word!!"
          puts result
        elsif result == "You guessed the word!!"
          puts result
          puts "\"#{game.return_revealed_word.the_word}\" was worth #{game.return_revealed_word.point_value} points."
          puts "Your current score for this game is #{game.get_score + game.return_revealed_word.point_value} \n" 
          return true
        elsif result
          puts "Correct! Keep going!"
        else
          puts "Oof sorry, closer to death."
        end
      end
    end

    # * in-game
    # *** print the word_so_far string, and accept guesses
    # *** print guesses remaining
    # *** print hangman doodle
    # *** points available for guessing this word correct (and difficulty)
    # *** points earned so far in this game
    # *** reserved words: "pause" "exit"
    # ******* if (guess word correctly) --> get new word, back to top
    # ******** if (guess wrong) --> call "die" method, output score from this game, and print "die message"
    # ****************** want to play again? 
    # *********************** yes --> back to top of in-game
    # *********************** no --> take back to logged-in menu
 
    private
  
    
  end


=begin
  "Welcome to Zak and Sam's hangman"
   * log in (using username)
    ** type in username, check if it exists, if no, direct to sign up menu
    *** if yes, take to logged-in menu
   * view leaderboard
   * sign up
   * exit / close the program

   * logged-in menu
   *** instructions & rules 
   *** view past scores
   *** view your high score
   *** view leaderboard
   *** if(exists a incomplete game) continue?
   *** new game
   ******* if (exists incomplete game), close it
   *** delete a score
   *** delete all scores
   *** update username
   *** view number of games played
   *** log-out
   ******* take to top menu


   * in-game
   *** print the word_so_far string, and accept guesses
   *** print guesses remaining
   *** print hangman doodle
   *** points available for guessing this word correct (and difficulty)
   *** points earned so far in this game
   *** reserved words: "pause" "exit"
   ******* if (guess word correctly) --> get new word, back to top
   ******** if (guess wrong) --> call "die" method, output score from this game, and print "die message"
   ****************** want to play again? 
   *********************** yes --> back to top of in-game
   *********************** no --> take back to logged-in menu

=end
