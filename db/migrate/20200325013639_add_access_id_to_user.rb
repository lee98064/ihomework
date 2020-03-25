class AddAccessIdToUser < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :access_id ,:integer ,default: 2
  	remove_column :users ,:admin
  end
end
