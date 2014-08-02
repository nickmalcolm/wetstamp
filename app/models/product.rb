class Product < ActiveRecord::Base
  belongs_to :shop
  has_many :product_images

  validates :shop, presence: true
  validates :shopify_id, presence: true, uniqueness: true
  
end
