class AddColorIntoVoteItems < ActiveRecord::Migration[5.2]
  def change
    add_column :vote_items, :color, :string, :after => :describe
  end
end
