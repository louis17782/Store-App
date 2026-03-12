class Product < ApplicationRecord
  has_many :CartItems
  has_one_attached :image

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :price_usd, numericality: { greater_than_or_equal_to: 0 }
  validates :price_bs, numericality: { greater_than_or_equal_to: 0 }
end
