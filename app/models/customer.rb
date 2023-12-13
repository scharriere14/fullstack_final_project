class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders, dependent: :nullify
  has_one :address, dependent: :nullify
  accepts_nested_attributes_for :address

  validates :email_address, uniqueness: true
  validates :customer_first, presence: true
  validates :customer_last, presence: true

  # def self.ransackable_attributes(auth_object = nil)
  #   ["address_id", "created_at", "customer_first", "customer_last", "email_address", "id",
  #    "id_value", "password", "updated_at"]
  # end

  # def self.ransackable_associations(auth_object = nil)
  #   ["address", "orders"]
  # end
end
