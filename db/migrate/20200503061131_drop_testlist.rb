class DropTestlist < ActiveRecord::Migration[5.2]
  def change
  	drop_table :testlists
  end
end
