class ProductImage < ActiveRecord::Base
  mount_uploader :original_image, WetstampUploader

  belongs_to :product
  has_one :shop, through: :product
  has_many :stamped_images

  validates :product, presence: true
  validates :shopify_id, presence: true, uniqueness: true

  def redownload_source_image
    self.remote_original_image_url = source_url
    save
  end

end
