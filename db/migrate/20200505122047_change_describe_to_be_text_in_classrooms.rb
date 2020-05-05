class ChangeDescribeToBeTextInClassrooms < ActiveRecord::Migration[5.2]
  def change
  	change_column :classrooms, :describe, :text
  end
end
