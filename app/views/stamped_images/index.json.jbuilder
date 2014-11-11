json.array!(@stamped_images) do |stamped_image|
  json.partial! "stamped_image", stamped_image: stamped_image
end
