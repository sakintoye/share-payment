class AddContactIdToContact < ActiveRecord::Migration
  def change
    add_reference :contacts, :contact, references: :users, after: :owner_id, index: true
    add_foreign_key :contacts, :users, column: :contact_id
  end
end
