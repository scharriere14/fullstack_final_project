class Product < ApplicationRecord
  has_many :orders

  def self.ransackable_attributes(auth_object = nil)
    ["consistency", "created_at", "id", "id_value", "price", "product_name", "scent", "stock", "updated_at", "usage"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["orders"]
  end

end
