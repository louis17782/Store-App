class Product < ApplicationRecord
  has_many :CartItems, dependent: :destroy
  has_one_attached :image

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :price_usd, numericality: { greater_than_or_equal_to: 0 }
  validates :price_bs, numericality: { greater_than_or_equal_to: 0 }
  validates :name, :description, :quantity, :image, :category, presence: true
end
