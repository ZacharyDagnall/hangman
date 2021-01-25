class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table(:games) do |t|
      t.integer :player_id
      t.boolean :complete
      t.string :word_so_far
      t.integer :wrong_guesses
    end
  end
end
