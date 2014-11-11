json.extract! stamped_image, :id, :original_image, :product_image_id, :stamp_id
json.stamped_image_url stamped_image.stamped_image.url
json.url stamped_image_url(stamped_image, format: :json)