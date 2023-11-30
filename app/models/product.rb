class Product < ApplicationRecord
  has_many :orders

  # Exclude plasma as an option
 # validates :consistency, exclusion: { in: ['plasma']}

end
