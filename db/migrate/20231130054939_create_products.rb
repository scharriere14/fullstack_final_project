class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :product_name
      t.float :price
      t.integer :stock
      t.string :scent
      t.string :consistency
      t.timestamps
    end
end
end