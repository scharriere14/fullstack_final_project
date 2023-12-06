# Address Table
10.times do
  address = Faker::Address.street_address
  city = Faker::Address.city
  province = Faker::Address.state_abbr
  postal_code = Faker::Address.postcode

  full_address = Address.create(
    address: address,
    city: city,
    province: province,
    postal_code: postal_code
  )

# Customer Table
  customer_first = Faker::Name.first_name
  customer_last = Faker::Name.last_name
    email_address = Faker::Internet.email
    password = Faker::Internet.password

    Customer.create(
      address_id: full_address.id,
      customer_first: customer_first,
      customer_last: customer_last,
      email_address: email_address,
      password: password
  )
end
