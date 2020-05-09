class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.string :title
      t.text :describe
      t.integer :classroom_id
      t.integer :user_id

      t.timestamps
    end
  end
end
