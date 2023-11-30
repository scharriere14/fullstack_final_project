json.extract! order, :id, :order_id, :product_name, :product_id, :customer_id, :tracking_number, :created_at, :updated_at
json.url order_url(order, format: :json)
