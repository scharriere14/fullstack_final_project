class Customer < ApplicationRecord
  has_many :orders
  has_one :address
  accepts_nested_attributes_for :address

  validates :email_address, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    ["address_id", "created_at", "customer_first", "customer_last", "email_address", "id", "id_value", "password", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["address", "orders"]
  end

end
