class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table(:games) do |t|
      t.integer :player_id
    end
  end
end
