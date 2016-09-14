class AddColumnsToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :sender_id, :integer, after: :id
    add_reference :payments, :recipient, references: :users, after: :id, index: true
    add_foreign_key :payments, :users, column: :recipient_id
  end
end
