class StampImage < ActiveRecord::Base
  mount_uploader :image, WetstampUploader
  belongs_to :shop
end
