class Product < ApplicationRecord
  has_many :orders, dependent: :nullify
  has_one_attached :image

  # Validations
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :consistency, presence: true
  validates :usage, presence: true

  # def self.ransackable_attributes(auth_object = nil)
  #   ["consistency", "created_at", "id", "id_value", "price", "product_name", "scent", "stock",
  #    "updated_at", "usage", "description"]
  # end

  # def self.ransackable_associations(auth_object = nil)
  #   ["orders"]
  # end

  def result_path
    result_path(self)
  end
end
