# Delete for testing. Comment out when in production
Product.delete_all

# Products table
def create_products(usage)
  10.times do |index|
    scent = Faker::Food.fruits
    consistency = Faker::Science.element_state

    next if skip_product_creation?(consistency)

    product = create_product(usage, scent, consistency)

    download_and_attach_image(product)

    log_product_creation_result(index, product)
  end
end

def skip_product_creation?(consistency)
  consistency.downcase == "unknown"
end

def create_product(usage, scent, consistency)
  Product.create(
    product_name: "#{scent} #{consistency} #{usage}",
    price:        rand(1..2999),
    stock:        Faker::Number.within(range: 1..100),
    scent:,           # Fix: Pass the scent variable
    consistency:,     # Fix: Pass the consistency variable
    usage:,           # Fix: Pass the usage variable
    description:  Faker::Lorem.paragraph(sentence_count: 10)
  )
end

def download_and_attach_image(product)
  query = URI.encode_www_form_component([product.product_name])
  downloaded_image = URI.open("https://source.unsplash.com/600x600/?#{query}")
  product.image.attach(io:       downloaded_image,
                       filename: "m-#{[product.product_name].join('-')}.jpg")
  sleep(1)
end

def log_product_creation_result(index, product)
  if product.persisted?
    Rails.logger.debug "Product #{index + 1} created: #{product.product_name}"
  else
    Rails.logger.debug "Failed to create product with consistency: #{product.consistency}"
  end
end

# Create 10 of each product
create_products("Dish Soap")
create_products("Laundry Soap")
create_products("Hand Soap")
create_products("Body Wash")
create_products("Bubble Bath")
create_products("Shampoo")
create_products("Conditioner")
create_products("Lotion")
