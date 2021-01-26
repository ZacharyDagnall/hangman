class HangmanPictures
    @@pics_arr= ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven"]

    def self.return_pic(index_num)
        @@pics_arr[index_num]
    end

end

