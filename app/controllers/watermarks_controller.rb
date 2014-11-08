class WatermarksController < ApplicationController
  around_filter :shopify_session
  before_filter :require_shop

  def create
    watermark = @current_shop.watermarks.new(watermark_params)
    if watermark.save
      render json: watermark, status: :created
    else
      render json: watermark.errors, status: :unprocessable_entity
    end
  end


  private

    def watermark_params
      params.require(:watermark).permit(:image)
    end
end
