json.extract! customer, :id, :customer_first, :customer_last, :email_address, :created_at, :updated_at
json.url customer_url(customer, format: :json)
