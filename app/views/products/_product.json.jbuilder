json.extract! product, :id, :product_name, :price, :stock, :scent, :consistency, :created_at,
              :updated_at
json.url product_url(product, format: :json)
