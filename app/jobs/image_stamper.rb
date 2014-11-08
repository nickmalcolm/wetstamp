class ImageStamper
  
  @queue = :default

  def self.perform(product_image_id)
    @product_image = ProductImage.find(product_image_id)
  end

  private


end