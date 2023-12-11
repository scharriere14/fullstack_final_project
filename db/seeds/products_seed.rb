# Delete for testing. Comment out when in production
Product.delete_all

# Products table
def create_products(usage)
  10.times do |index|
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
      price: rand(1..2999),
      stock: Faker::Number.within(range: 1..100),
      scent: scent,
      consistency: consistency,
      usage: usage,
      description: Faker::Lorem.paragraph(sentence_count: 10)
    )

    query = URI.encode_www_form_component([product.product_name])
    downloaded_image = URI.open("https://source.unsplash.com/600x600/?#{query}")
    product.image.attach(io: downloaded_image, filename: "m-#{[product.product_name].join('-')}.jpg")
    sleep(1)

    if product.persisted?
      puts "Product #{index + 1} created: #{product.product_name}"
    else
      puts "Failed to create product with consistency: #{consistency}"
    end
  end
end

# Create 10 of each product
create_products('Dish Soap')
create_products('Laundry Soap')
create_products('Hand Soap')
create_products('Body Wash')
create_products('Bubble Bath')
create_products('Shampoo')
create_products('Conditioner')
create_products('Lotion')
