class ProductImage < ActiveRecord::Base
  mount_uploader :original_image, WetstampUploader
  mount_uploader :stamped_image, WetstampUploader

  belongs_to :product
  has_one :shop, through: :product

  validates :product, presence: true
  validates :shopify_id, presence: true, uniqueness: true

end
