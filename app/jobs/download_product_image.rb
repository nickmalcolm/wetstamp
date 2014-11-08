class DownloadProductImage
  @queue = :default
  
  def self.perform(product_image_id)
    puts "[DownloadProductImage] Perform download of image for ProductImage ##{product_image_id}"
    @product_image = ProductImage.find(product_image_id)
  end

end