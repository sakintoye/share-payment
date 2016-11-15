class AddRegistrationStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :registration_status, :integer, after: :email
  end
end
