class Order < ApplicationRecord
  belongs_to :product
  belongs_to :customer

  # reqired for admin
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "customer_id", "id", "id_value", "product_id", "product_name", "tracking_number", "updated_at"]
  end
end
