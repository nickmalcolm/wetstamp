class StampedImage < ActiveRecord::Base
  mount_uploader :original, WetstampUploader
  mount_uploader :stamped,  WetstampUploader

  belongs_to :product_image
  belongs_to :stamp
  belongs_to :watermark
  
end
