class Address < ApplicationRecord
  belongs_to :customer

  # The _ or _auth_object is a convention in Ruby to indicate that the method parameter won't be
  # used within the method body.
  def self.ransackable_attributes(_auth_object = nil)
    ["address", "city", "created_at", "customer_id", "id",
     "id_value", "postal_code", "province",
     "updated_at"]
  end
end
