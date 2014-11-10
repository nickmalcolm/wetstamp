require 'net/https'
class ImageStamper
  
  @queue = :default

  def work(stamp_id, product_image_id)
    stamp = Stamp.find(stamp_id)
    product_image = ProductImage.find(product_image_id)

    puts "[ImageStamper] Fetching remote image and watermark"
    image = get_remote_image(product_image.original_image.url)
    watermark = get_remote_image(stamp.watermark.image.url)
    
    puts "[ImageStamper] Stamping image"

    result = stamp_to_file(stamp, image, watermark)

    puts "[ImageStamper] Saving StampedImage from file at #{result.path}"
    stamped_image = StampedImage.create!(
      stamp: stamp,
      product_image: product_image,
      original_image: product_image.original_image.url,
      watermark: stamp.watermark,
      stamped_image: result
    )

    puts "[ImageStamper] Done. Created StampedImage##{stamped_image.id}"

    stamped_image
  end

  private

    def stamp_to_file(stamp, image, watermark)
      path = "#{Dir.tmpdir}/#{SecureRandom.uuid}.#{image.format.downcase}"
      stamped_image = apply_stamp(stamp, image, watermark)
      stamped_image.write(path)
      File.new path 
    end

    def apply_stamp(stamp, image, watermark)
      # Rotate the watermark
      watermark.rotate!(stamp.rotate) unless stamp.rotate.eql?(0)

      # Tile the watermark if needed
      if stamp.tiled?
        watermark = tile_watermark(image, watermark)
      end

      # Dissolve the watermark on to the image
      image.dissolve(
        watermark,
        stamp.transparency,
        1.0,
        stamp.position
      )
    end

    def tile_watermark(image, watermark)
      canvas = transparent_canvas_for_image(image)
      canvas.composite_tiled(watermark)
    end

    def transparent_canvas_for_image(image)
      Magick::Image.read("xc:none") { self.size = "#{image.rows}x#{image.columns}" }.first
    end

    def get_remote_image(url)
      downloaded_file = download_file(url)
      result = nil
      File.open downloaded_file.path do |file|
        result = Magick::Image.read(file).first
      end
      result
    end

    def download_file(url)
      uri = URI(url)
      https = uri.scheme.eql?('https')
      http = Net::HTTP.new(uri.host, https ? 443 : 80)
      http.use_ssl = https
      
      request = Net::HTTP::Get.new uri.request_uri

      http.request request do |response|

        case response
        when Net::HTTPSuccess
          tempfile = Tempfile.new("ImageStamperDownload-", Dir.tmpdir, 'wb+').binmode

          response.read_body do |chunk|
            tempfile.write chunk
          end
          tempfile.flush

          return tempfile
        end
      end

      raise "Could not download #{url}"
    end

end