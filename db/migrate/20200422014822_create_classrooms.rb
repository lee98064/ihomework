class CreateClassrooms < ActiveRecord::Migration[5.2]
  def change
    create_table :classrooms do |t|
      t.string :name, presence: true
      t.string :describe, presence: true
      t.string :addcode
      t.integer :user_id
      t.timestamps
    end
  end
end
