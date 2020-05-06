class CreateWeeknotesubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :weeknotesubjects do |t|
      t.string :title
      t.text :describe
      t.integer :user_id
      t.integer :classroom_id

      t.timestamps
    end
  end
end
