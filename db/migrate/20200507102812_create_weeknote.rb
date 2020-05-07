class CreateWeeknote < ActiveRecord::Migration[5.2]
  def change
    create_table :weeknotes do |t|
    	t.references :weeknotesubject, foreign_key: true
    	t.text :content
    	t.string :score
    	t.text :suggest
    	t.integer :user_id

      t.timestamps
    end
  end
end
