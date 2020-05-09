class CreateVoteItems < ActiveRecord::Migration[5.2]
  def change
    create_table :vote_items do |t|
      t.string :title
      t.text :describe
      t.integer :vote_id
      t.integer :vote_logs_count

      t.timestamps
    end
  end
end
