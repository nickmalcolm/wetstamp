class StampedImage < ActiveRecord::Base

  belongs_to :product_image
  belongs_to :stamp
  belongs_to :watermark
  
end
