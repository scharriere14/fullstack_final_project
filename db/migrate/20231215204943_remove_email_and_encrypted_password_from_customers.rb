class RemoveEmailAndEncryptedPasswordFromCustomers < ActiveRecord::Migration[7.1]
  def change
    remove_column :customers, :email
    remove_column :customers, :encrypted_password
  end
end
