class Hangman
    # here will be your CLI!
    # it is not an AR class so you need to add attr
  
    attr_reader :prompt
    @@key_words = ["pause", "exit"]

    def initialize
      @prompt = TTY::Prompt.new
    end

    def run
      top_menu
    end

    def top_menu
      continue = true
      while continue
        prompt.select("Welcome to hangman") do |menu|
          menu.choice "log in" , -> {log_in}
          menu.choice "sign up", -> {sign_up}
          menu.choice "view leaderboard", -> {puts Game.leader_board}
          menu.choice "exit", -> {self.exit}
        end
      end
    end

    def logged_in_menu(player)
      if player.open_game?
        prompt.yes?("Continue last game?") ###
      end
      continue=true
      while (continue)
        prompt.select("Welcome #{player.username}!") do |menu|
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
      if !player
        sign_up
      else 
        logged_in_menu(player)
      end
    end

    def sign_up
      usrnm = prompt.ask("What would you like your username to be?").capitalize
      while (Player.find_by(username: usrnm) && usrnm != "exit")
        puts "This username is already taken!"
        usrnm = prompt.ask("What would you like your username to be?").capitalize
      end
      if (usrnm != "exit")
        player = Player.create(username: usrnm)
      end
      logged_in_menu(player)
    end

    def instructions_and_rules
      puts "........ these are the rules"
    end

    def delete_a_score(player)
      score = prompt.ask("What score do you want to delete?").to_f
      sure = prompt.yes?("Are you 💯 ???")
      if sure
        player.delete_score(score)
      end
    end

    def delete_all_scores(player)
      sure = prompt.yes?("You sure you wanna delete all scores my guy???")
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

    def run_game(player)

    end

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
