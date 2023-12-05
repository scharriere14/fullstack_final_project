
# Deelte for testing. Comment out when in production
Product.delete_all

# products table
def create_products(usage)
  10.times do
    scent = Faker::Food.fruits
    consistency = Faker::Science.element_state

    next if consistency.downcase == 'unknown'

    # Change consistency to 'powder' if it was 'gas'
    if consistency.downcase == 'gas'
      consistency = 'powder'
    end
    # Change consistency to 'whipped' if it was 'plasma'
    if consistency.downcase == 'plasma'
      consistency = 'whipped cream'
    end

    product = Product.create(
      product_name: "#{scent} #{consistency} #{usage}",
      price: Faker::Number.decimal(l_digits: 2),
      stock: Faker::Number.within(range: 1..100),
      scent: scent,
      consistency: consistency,
      usage: usage
    )

    # if product.persisted?
    #   puts "Product created: #{product.product_name}"
    # else
    #   puts "Failed to create product with consistency: #{consistency}"
    # end
  end
end

# Create 10 of each products
create_products('Dish Soap')
create_products('Laundry Soap')
create_products('Hand Soap')
create_products('Body Wash')
create_products('Bubble Bath')
create_products('Shampoo')
create_products('Conditioner')
create_products('Lotion')

