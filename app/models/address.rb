class Address < ApplicationRecord
  belongs_to :customer

  # def self.ransackable_attributes(auth_object = nil)
  #   ["address", "city", "created_at", "customer_id", "id", "id_value", "postal_code", "province",
  #    "updated_at"]
  # end
end
