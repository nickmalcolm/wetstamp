class ProductImage < ActiveRecord::Base
  mount_uploader :original_image, WetstampUploader
  mount_uploader :stamped_image, WetstampUploader

  belongs_to :product
  has_one :shop, through: :product
  has_many :stamped_images

  validates :product, presence: true
  validates :shopify_id, presence: true, uniqueness: true

  after_save :queue_image_download

  def queue_image_download
    Resque.enqueue(DownloadProductImage, id)
  end

end
