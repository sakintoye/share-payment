class AddAmountToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :amount, :decimal, precision: 15, scale: 2, after: :sender_id
  end
end
