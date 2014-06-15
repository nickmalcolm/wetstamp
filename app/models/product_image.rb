class ProductImage < ActiveRecord::Base
  mount_uploader :watermarked_image, WetstampUploader

  belongs_to :product

  validates :product, presence: true
  validates :shopify_id, presence: true, uniqueness: true

end
