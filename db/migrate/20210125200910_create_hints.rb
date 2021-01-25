class CreateHints < ActiveRecord::Migration[5.2]
  def change
    create_table(:hints) do |t|
      t.integer :word_id
      t.string :the_hint
      t.float :point_deduction
    end
  end
end
