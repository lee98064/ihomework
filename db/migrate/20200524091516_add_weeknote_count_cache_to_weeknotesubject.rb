class AddWeeknoteCountCacheToWeeknotesubject < ActiveRecord::Migration[5.2]
  def change
    add_column :weeknotesubjects, :weeknotes_count, :integer, :after => :describe
  end
end
