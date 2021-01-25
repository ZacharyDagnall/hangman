class CreateWords < ActiveRecord::Migration[5.2]
  def change
    create_table(:words) do |t|
      t.string :the_word
      t.float :point_value
    end
  end
end
