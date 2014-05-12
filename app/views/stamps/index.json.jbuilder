json.array!(@stamps) do |stamp|
  json.extract! stamp, :id, :shop_id, :name, :image, :rotate, :transparency, :position, :tiled
  json.url stamp_url(stamp, format: :json)
end
