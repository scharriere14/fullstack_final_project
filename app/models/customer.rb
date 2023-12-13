class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders, dependent: :nullify
  has_one :address, dependent: :nullify
  accepts_nested_attributes_for :address

  # validates :email_address, uniqueness: true
  # validates :customer_first, presence: true
  # validates :customer_last, presence: true
end
