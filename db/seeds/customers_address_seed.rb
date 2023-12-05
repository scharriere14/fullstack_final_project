Address.delete_all
Customer.delete_all

# Seed data
10.times do |i|
  customer_first = Faker::Name.first_name
  customer_last = Faker::Name.last_name
  email_address = customer_first.downcase + Faker::Internet.email
  password = Faker::Internet.password

  puts email_address

  # Create a customer with an associated address
  customer = Customer.create!(
    customer_first: customer_first,
    customer_last: customer_last,
    email_address: email_address,
    password: password,
    address_attributes: {
      address: Faker::Address.street_address,
      city: Faker::Address.city,
      province: Faker::Address.state_abbr,
      postal_code: Faker::Address.postcode
    }
  )

  #puts "Customer ID: #{customer.id} Customer name: #{customer.customer_first} #{customer.customer_last} #{customer.email_address}" if customer.persisted?
end