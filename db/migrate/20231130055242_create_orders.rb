# db/migrate/[timestamp]_create_orders.rb
class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :product_name
      t.references :product, foreign_key: true
      t.references :customer, foreign_key: true
      t.integer :tracking_number
      t.timestamps
    end
  end
end
