class Product < ApplicationRecord
  has_many :orders, dependent: :nullify
  has_one_attached :image

  # Validations
  validates :product_name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :consistency, presence: true
  validates :usage, presence: true

  def result_path
    # result_path(self)
    "/products/#{product_name.parameterize}"
  end
end
