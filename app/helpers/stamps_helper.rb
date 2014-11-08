module StampsHelper

  def preview_image_for(shop)
    shop.product_images.first.try(:source_url) || "placeholder_product.jpg"
  end

end
