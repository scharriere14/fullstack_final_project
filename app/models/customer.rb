class Customer < ApplicationRecord
  has_many :orders, dependent: :nullify
  has_one :address, dependent: :nullify
  accepts_nested_attributes_for :address

  validates :email_address, uniqueness: false
  validates :customer_first, presence: true
  validates :customer_last, presence: true
end
