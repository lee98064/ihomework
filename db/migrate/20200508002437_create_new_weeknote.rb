class CreateNewWeeknote < ActiveRecord::Migration[5.2]
  def change
    create_table :weeknotes do |t|
      t.text :content
      t.integer :user_id
      t.integer :weeknotesubject_id
      t.timestamps
    end
  end
end
