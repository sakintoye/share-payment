class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :invite_mode
      t.string :sender_id
      t.string :contact_info
      t.integer :status

      t.timestamps null: false
    end
  end
end
