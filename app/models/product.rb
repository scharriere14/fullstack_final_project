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
    result_path(self)
  end

  # def self.search(keyword, category)
  #   products = all

  #   products = filter_by_keyword(products, keyword)
  #   filter_by_category(products, category)
  # end

  # def self.filter_by_keyword(products, keyword)
  #   return products unless keyword.present?

  #   Rails.logger.debug "DEBUG: Filtering by keyword: #{keyword}"
  #   products.where("product_name LIKE ?", "%#{keyword}%")
  # end

  # def self.filter_by_category(products, category)
  #   return products unless category.present? && category != "All Categories"

  #   Rails.logger.debug "DEBUG: Filtering by category: #{category}"
  #   products.where("TRIM(LOWER(usage)) = ?", category.downcase.strip)
  # end

  # Option 2: Simplified Conditions
  def self.search(keyword, category)
    products = all

    if keyword.present?
      Rails.logger.debug "DEBUG: Filtering by keyword: #{keyword}"
      products = products.where("product_name LIKE ?", "%#{keyword}%")
    end

    if category.present? && category != "All Categories"
      Rails.logger.debug "DEBUG: Filtering by category: #{category}"
      products = products.where("TRIM(LOWER(usage)) = ?", category.downcase.strip)
    end

    products
  end
end
