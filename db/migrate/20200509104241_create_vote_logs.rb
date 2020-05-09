class CreateVoteLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :vote_logs do |t|
      t.integer :vote_id
      t.integer :vote_item_id
      t.integer :user_id
      t.string :ip_address

      t.timestamps
    end
  end
end
