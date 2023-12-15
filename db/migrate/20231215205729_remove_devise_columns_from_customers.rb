class RemoveDeviseColumnsFromCustomers < ActiveRecord::Migration[7.1]
  def change
    remove_column :customers, :email
    remove_column :customers, :encrypted_password
    remove_column :customers, :reset_password_token
    remove_column :customers, :reset_password_sent_at
    remove_column :customers, :remember_created_at
  end
end
