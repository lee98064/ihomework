class AddScoreToWeeknote < ActiveRecord::Migration[5.2]
  def change
    add_column :weeknotes, :score, :string
    add_column :weeknotes, :suggest, :text
  end
end
