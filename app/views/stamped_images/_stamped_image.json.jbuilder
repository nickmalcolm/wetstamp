json.extract! stamped_image, :id, :original_image, :product_image_id
json.stamped_image_url stamped_image.stamped_image.url
json.url shop_stamped_image_url(current_shop, stamped_image, format: :json)