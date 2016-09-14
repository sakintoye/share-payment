class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :user_id
      t.integer :owner_id

      t.timestamps null: false
    end
  end
end
