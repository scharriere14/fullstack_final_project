class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.text :customer_first
      t.text :customer_last
      t.string :email_address

      t.timestamps
    end
  end
end
