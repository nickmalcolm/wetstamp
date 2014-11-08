class StampedImage < ActiveRecord::Base
  mount_uploader :stamped_image,  WetstampUploader

  belongs_to :product_image
  belongs_to :stamp
  belongs_to :watermark
  
end
