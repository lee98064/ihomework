class Testlists < ActiveRecord::Migration[5.2]
  def change
  	create_table :testlists do |t|
      t.string :title
      t.text :describe
      t.datetime :start
      t.datetime :end
      t.string :color
      t.integer :user_id
      t.integer :classroom_id

      t.timestamps
    end
  end
end
