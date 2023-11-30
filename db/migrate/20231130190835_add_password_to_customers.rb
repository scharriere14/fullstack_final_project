class AddPasswordToCustomers < ActiveRecord::Migration[7.1]
  def change
    add_column :customers, :password, :string
  end
end
