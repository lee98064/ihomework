class CreateScoresheets < ActiveRecord::Migration[5.2]
  def change
    create_table :scoresheets do |t|
      t.string :name
      t.string :describe
      t.integer :user_id
      t.integer :classroom_id

      t.timestamps
    end
  end
end
