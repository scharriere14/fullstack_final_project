class AddCustomerIdToAddresses < ActiveRecord::Migration[7.1]
  def change
    add_reference :addresses, :customer, null: false, foreign_key: true
  end
end
