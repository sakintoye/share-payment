class RemoveUserId < ActiveRecord::Migration
  def change
    remove_column :contacts, :user_id
  end
end
