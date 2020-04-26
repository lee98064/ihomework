class CreateTestlists < ActiveRecord::Migration[5.2]
  def change
    create_table :testlists do |t|
      t.string :title
      t.text :describe
      t.datetime :starttime
      t.datetime :endtime
      t.integer :user_id
      t.integer :classroom_id

      t.timestamps
    end
  end
end
