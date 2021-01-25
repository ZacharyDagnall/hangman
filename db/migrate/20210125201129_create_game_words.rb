class CreateGameWords < ActiveRecord::Migration[5.2]
  def change
    create_table(:game_words) do |t|
      t.integer :game_id
      t.integer :word_id
    end
  end
end
