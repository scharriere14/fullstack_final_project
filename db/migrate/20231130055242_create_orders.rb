class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.integer :order_id
      t.text :product_name
      t.integer :product_id
      t.integer :customer_id
      t.integer :tracking_number

      t.timestamps
    end
  end
end
