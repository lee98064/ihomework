class RemoveAccessTable < ActiveRecord::Migration[5.2]
  def change
  	drop_table :accesses
  	remove_column :users ,:access_id
  end
end
