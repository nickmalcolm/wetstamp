class StampedImagesController < ApplicationController
  before_filter :require_shop
  around_filter :shopify_session

  def index
    @stamped_images = stamped_images
    respond_to do |format|
      format.json
    end
  end

  def show
    @stamped_image = current_shop.stamped_images.find("#{params[:id]}".to_i)
  end

  private

    def shop_previews
      @_shop_previews ||= current_shop.previews
    end

    def stamped_images
      shop_previews.stamped_images
    end
end
