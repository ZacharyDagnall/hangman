class Player<ActiveRecord::Base
    has_many :games

    def top_score
        if self.games.size == 0
            return "You have no saved scores"
        end
        score = self.games.max_by{|game| game.get_score}.get_score
        "Your highest score is #{score} \n\n"
    end

    def delete_score(score)
        goodbye_game = self.games.find{|game| game.get_score==score}
        if !goodbye_game
            return false
        else
            Game.destroy(goodbye_game.id) 
        end
    end

    def delete_all_scores
        self.games.destroy_all
    end

    def num_games_played
        self.games.size
    end

    def view_all_scores
        if self.games.size == 0
           return "You have no saved scores\n"
        end
        self.games.map{|game|game.get_score}.sort.reverse.join("\n") + "\n\n"
    end
    
end