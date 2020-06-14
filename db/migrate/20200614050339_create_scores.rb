class CreateScores < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.integer :stunumber
      t.integer :score
      t.integer :scoresheet_id

      t.timestamps
    end
  end
end
