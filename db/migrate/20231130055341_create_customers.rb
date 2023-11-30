# db/migrate/[timestamp]_create_customers.rb
class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :customer_first
      t.string :customer_last
      t.references :address, foreign_key: true
      t.string :email_address
      t.timestamps
    end
  end
end
