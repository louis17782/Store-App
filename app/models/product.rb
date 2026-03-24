class Product < ApplicationRecord
  belongs_to :category, optional: true
  has_many :CartItems, dependent: :destroy
  has_one_attached :image
  has_many_attached :slider_images

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :price_usd, numericality: { greater_than_or_equal_to: 0 }
  validates :price_bs, numericality: { greater_than_or_equal_to: 0 }
  validates :name, :description, :quantity, :image, :sale_type, presence: true
  scope :with_slider_images, -> {
      joins(:slider_images_attachments)
    }
end
