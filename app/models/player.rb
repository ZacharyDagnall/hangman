class Player<ActiveRecord::Base
    has_many :games



    
    def top_score
        score = self.games.max_by{|game| game.get_score}.get_score
        "Your highest score was #{score}"
    end

    def delete_score(score)
        self.games.find{|game| game.get_score==score}.destroy
    end

    def delete_all_scores
        self.games.destroy_all
    end

    def num_games_played
        self.games.size
    end

    def list_all_scores
        str = ""
        self.games.each do |game|
            str += "#{game.get_score}\n"
        end
    end

end