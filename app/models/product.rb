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

  def self.search(keyword, category)
    products = all

    if keyword.present? && category.present? && category != "All Categories"
      Rails.logger.debug "DEBUG: Filtering by keyword: #{keyword}"
      Rails.logger.debug "DEBUG: Filtering by category: #{category}"
      products = products.where("product_name LIKE ? AND TRIM(LOWER(usage)) = ?", "%#{keyword}%",
                                category.downcase.strip)
    elsif keyword.present? && (category.blank? || category == "All Categories")
      Rails.logger.debug "DEBUG: Filtering by keyword: #{keyword}"
      products = products.where("product_name LIKE ?", "%#{keyword}%")
    elsif category.present? && keyword.blank?
      Rails.logger.debug "DEBUG: Filtering by category: #{category}"
      products = products.where("TRIM(LOWER(usage)) = ?", category.downcase.strip)
    end

    products
  end
end
