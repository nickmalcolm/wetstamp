module StampsHelper

  def preview_image_for(shop)
    shop.product_images.first
  end

end
