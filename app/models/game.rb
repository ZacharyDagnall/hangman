class Game<ActiveRecord::Base

    belongs_to :player
    has_many :game_words
    has_many :words, through: :game_words

    #after_initialize :set_initial_values
    attr_reader :wrong_guesses, :word_so_far, :guessed_letters, :guessed_words

    @@MAX_WRONGS = 10

    def get_score
        if self.words.length==0
            return 0
        end
        self.words.sum{|word| word.point_value} - (self.hints_used * 2)
    end

    def get_word
        self.words << retrieve_word
        @word_so_far = Game.concealed_word(self.words.last.the_word)
        @guessed_letters = ""
        @guessed_words = []
        @wrong_guesses = 0
        self.words.last
    end

    def retrieve_word       
        if Word.all.size == self.words.size    #guarding against a player playing every word in the database
            puts "Congrats, you're a freak!"
            return nil
        end 
        new_word = Word.all.sample
        while self.words.include?(new_word) do
            new_word = Word.all.sample
        end
        new_word
    end

    def self.concealed_word(word)
        concealed_word_str = ""
        word.length.times do
            concealed_word_str += "_"
        end
        return concealed_word_str
    end

    def word_is_finished?
       !@word_so_far.include?("_")
    end

    def make_guess(guess)
        if !guess #nothing was actually entered
            return
        end
        current_word = self.words.last.the_word
        if guess.length==1
            return make_one_char_guess(current_word, guess)
        elsif already_guessed_word?(guess)
            return "You've already guessed this word!!"
        elsif guess.length == current_word.length 
           return make_whole_word_guess(current_word, guess)
        else 
            @wrong_guesses +=1
            return false
        end
    end

    def make_one_char_guess(current_word, guess)
        if already_guessed_letter?(guess)
            return "You've already guessed this letter!!"
        end
        if current_word.include?(guess)
            current_word.length.times do |i|
                if current_word[i] == guess
                    @word_so_far[i] = guess
                end
            end
            if word_is_finished?
                return "You guessed the word!!"
            end
            return true
        else 
            @wrong_guesses +=1
            return false
        end
    end

    def make_whole_word_guess(current_word, guess)
        if guess == current_word
            return "You guessed the word!!"
       else
            @wrong_guesses +=1
            return false 
       end
    end
        

    def already_guessed_letter?(guess)
        if @guessed_letters.include?(guess)
            true
        else
            @guessed_letters+=guess
            false
        end
    end

    def already_guessed_word?(guess)
        if @guessed_words.include?(guess)
            true
        else
            @guessed_words.push(guess)
            false
        end
    end

    def guesses_remaining
        @@MAX_WRONGS - @wrong_guesses
    end

    def die 
        Word.destroy(self.words.last.id)
    end

    def self.leader_board
        str = ""
        toppers = self.all.max_by(10){|game| game.get_score}
        counter = 1
        toppers.each do |topper|
            str += "#{counter}. #{topper.player.username}: #{topper.get_score} \n"
            counter += 1
        end
        str + "\n"
    end 

    def print_concealed_word
       puts @word_so_far.split('').join(" ")
    end

    def return_revealed_word
        self.words.last
    end

    def get_hint(hint_type)
        self.update(hints_used: self.hints_used+1)
        case hint_type
        when :vowel
            generate_vowels_hint
        when :obscure
            generate_obscure_hint
        when :repeating
            generate_repeating_hint
        end 
    end

    private

    def generate_vowels_hint
        the_word = self.words.last.the_word
        vowels_arr = %w(a,e,i,o,u)
        num = vowels_arr.sum{|letter| the_word.count(letter)}
        if num == 0
            return "There are no 'A's, 'E's, 'I's, 'O's, or 'U's! Surely you must be asking 'Y'?"
        end
        "#{num} of these letters #{is_or_are(num)} #{plural_or_not(num, "vowel")}."
    end

    def generate_obscure_hint
        the_word = self.words.last.the_word.split("").uniq
        obscure_arr = %w(j, q, x, z)
        found = the_word.any?{|letter| obscure_arr.include?(letter)}
        if found 
            "This word contains one or more of these obscure letters: 'J', 'Q', 'X' or 'Z'"
        else
            "This word does not contain any these obscure letters: 'J', 'Q', 'X' or 'Z'"
        end
    end

    def generate_repeating_hint
        the_word = self.words.last.the_word
        arr_of_letters = the_word.split("").uniq
        the_hash = {}
        arr_of_letters.each do |letter|
            the_hash[letter] = the_word.count(letter)
        end
        max_arr = the_hash.max_by{|key, val| val}
        if max_arr[1] == 1
            "This word has no repeating letters"
        else
            "This word has a letter that shows up #{max_arr[1]} times"
        end
    end

    def plural_or_not(num, string)
        the_string = string
        if num  != 1
            the_string = string + 's'
        end
        "#{the_string}"
    end

    def is_or_are(num)
        if num == 1
            "is a"
        else
            "are"
        end
    end

    #unused (and uncalled), because we set the default value in the  active record table instead.
    def set_initial_values
        self.hints_used = 0
    end

end