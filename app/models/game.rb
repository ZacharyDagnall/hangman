class Game<ActiveRecord::Base
    belongs_to :player
    has_many :game_words
    has_many :words, through: :game_words

    after_initialize :set_initial_values

    def get_score   #for now assuming no hints 
        if !self.complete
            self.words.sum{|word| word.point_value} - self.words.last.point_value
        else 
            self.words.sum{|word| word.point_value}
        end
    end

    def get_word
        self.words << retrieve_word
        self.word_so_far = Game.concealed_word(self.words.last.the_word)
    end

    def retrieve_word       
        if Word.all.size == self.words.size
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
        word_size = word.length
        concealed_word_str = ""
        word_size.times do
            concealed_word_str += "_"
        end
        return concealed_word_str
    end

    def make_guess(guess)
        current_word = self.words.last
        if guess.length==1
            if current_word.include?(guess)
                current_word.length.times do |i|
                    if current_word[i] == guess
                        self.word_so_far[i] = guess
                    end
                end
                return true
            else 
                self.wrong_guesses +=1
                return false
            end
        elsif guess.length == current_word.length
           if guess == current_word
                return "You guessed the word!!"
           else
                self.wrong_guesses +=1
                return false 
           end
        else 
            self.wrong_guesses +=1
            return false
        end
    end

    def die 
        self.words.pop 
        self.complete = true
    end

    def self.leader_board
        str = ""
        toppers = self.all.max_by(10){|game| game.get_score|}
        counter = 0
        toppers.each do |topper|
            str += "#{counter}. #{topper.player.username}: #{topper.get_score} \n"
            counter += 1
        end
        str
    end 

    private

    def set_initial_values
        self.complete = false
        self.wrong_guesses = 0
    end

end