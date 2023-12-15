# db/seeds/customers_address_seed.rb
Address.delete_all
Customer.delete_all

# Seed data
10.times do |i|
  customer_first = Faker::Name.first_name
  customer_last = Faker::Name.last_name
  email_address = customer_first.downcase + Faker::Internet.email
  password = Faker::Internet.password

  # Create a customer with an associated address
  customer = Customer.create!(
    email:              email_address,
    password:, # Devise will handle encryption
    customer_first:,
    customer_last:,
    address_attributes: {
      address:     Faker::Address.street_address + Faker::Address.street_address + Faker::Address.street_suffix,

      city:        Faker::Address.city,
      province:    Faker::Address.province,
      postal_code: Faker::Address.postcode
    }
  )

  Rails.logger.debug "Customer #{i + 1} created: #{customer.email}"
end
