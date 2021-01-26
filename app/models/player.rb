class Player<ActiveRecord::Base
    has_many :games

    def top_score
        score = self.games.max_by{|game| game.get_score}.get_score
        "Your highest score was #{score}"
    end

    def delete_score(score)
        goodbye_game = self.games.find{|game| game.get_score==score}
        if !goodbye_game
            return false
        else
            Game.destroy(goodbye_game.id) ##so this will return a "truthy" value i believe
        end

    end

    def delete_all_scores
        self.games.destroy_all
    end

    def num_games_played
        self.games.size
    end

    def view_all_scores
        str = ""
        self.games.each do |game|
            str += "#{game.get_score}\n"
        end
        str
    end

    def open_game?
        self.games.any?{|game| game.complete=false}
    end

end