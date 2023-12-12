Address.delete_all
Customer.delete_all

# Seed data
10.times do
  customer_first = Faker::Name.first_name
  customer_last = Faker::Name.last_name
  email_address = customer_first.downcase + Faker::Internet.email
  password = Faker::Internet.password

  # Create a customer with an associated address
  Customer.create!(
    customer_first:,
    customer_last:,
    email_address:,
    password:,
    address_attributes: {
      address:     Faker::Address.street_address,
      city:        Faker::Address.city,
      province:    Faker::Address.state_abbr,
      postal_code: Faker::Address.postcode
    }
  )
end
