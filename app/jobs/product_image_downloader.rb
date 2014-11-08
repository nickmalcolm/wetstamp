class ProductImageDownloader

  @queue = :default
  
  def self.perform(product_image_id)
    puts "[ProductImageDownloader] Telling ProductImage ##{product_image_id} to redownload_source_image"
    @product_image = ProductImage.find(product_image_id)
    @product_image.redownload_source_image
  end

end