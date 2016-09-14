class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :reason
      t.integer :status
      t.datetime :date_sent
      t.datetime :date_withdrawn

      t.timestamps null: false
    end
  end
end
