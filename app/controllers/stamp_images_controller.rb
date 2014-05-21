class StampImagesController < ApplicationController
  around_filter :shopify_session
  before_filter :require_shop

  def create
    stamp_image = @current_shop.stamp_images.new(stamp_image_params)
    if stamp_image.save
      render json: stamp_image, status: :created
    else
      render json: stamp_image.errors, status: :unprocessable_entity
    end
  end


  private

    def stamp_image_params
      params.require(:stamp_image).permit(:image)
    end
end
