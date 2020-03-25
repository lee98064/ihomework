class CreateAccesses < ActiveRecord::Migration[5.2]
  def change
    create_table :accesses do |t|
      t.string :accesstype

      t.timestamps
    end
    Access.create(accesstype: "Admin")
    Access.create(accesstype: "User")
  end
end
