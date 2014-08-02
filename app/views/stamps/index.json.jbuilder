json.array!(@stamps) do |stamp|
  json.extract! stamp, :id, :shop_id, :name, :stamp_image_id, :rotate, :transparency, :position, :tiled
  json.url stamp_url(stamp, format: :json)
end
