class ShopPreviews
  
  attr_accessor :shop, :stamp, :product_images

  def initialize(shop, stamp)
    @shop = shop
    @stamp = stamp
    @product_images = shop.product_images.first(3)
  end

  def generate_previews(regenerate=false)
    @product_images.each do |product_image|
      if product_image.current_stamped_image.nil? || regenerate
        product_image.create_stamped_image(@stamp)
      end
    end
    true
  end

  def ready?
    @product_images.all? {|product_image| product_image.current_stamped_image.present? }
  end

  def stamped_images
    @product_images.collect(&:current_stamped_image)
  end

end