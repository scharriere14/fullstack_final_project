class AddDescriptionToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :description, :text
    Product.all.each { |product| product.update(description: Faker::Lorem.paragraph) }

  end
end
