# Seeds to indivudual pages
require_relative "seeds/products_seed"
require_relative "seeds/customers_address_seed"
require_relative "seeds/orders_seed"

# Active Admin login information
if Rails.env.development?
  AdminUser.create!(email: "admin@example.com", password: "password",
                    password_confirmation: "password")
end
