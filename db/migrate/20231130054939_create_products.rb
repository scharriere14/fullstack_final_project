class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.text :product_name
      t.float :price
      t.integer :stock
      t.text :scent
      t.text :consistency

      t.timestamps
    end
  end
end
