class RemoveResetPasswordTokenFromCustomers < ActiveRecord::Migration[7.1]
  def change
    remove_column :customers, :reset_password_token
  end
end
