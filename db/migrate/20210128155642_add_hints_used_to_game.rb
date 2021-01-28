class AddHintsUsedToGame < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :hints_used, :integer, default: 0
  end
end
