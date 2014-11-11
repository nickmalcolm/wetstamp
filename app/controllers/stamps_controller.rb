class StampsController < ApplicationController
  around_filter :shopify_session
  before_filter :require_shop
  before_action :set_stamp, only: [:show, :edit, :update, :destroy, :preview]

  # GET /stamps
  # GET /stamps.json
  def index
    @stamps = @current_shop.stamps
  end

  # GET /stamps/1
  # GET /stamps/1.json
  def show
  end

  # GET /stamps/new
  def new
    @stamp = @current_shop.stamps.new
  end

  # GET /stamps/1/edit
  def edit
  end

  # POST /stamps
  # POST /stamps.json
  def create
    @stamp = @current_shop.stamps.new(stamp_params)

    respond_to do |format|
      if @stamp.save!
        
        ShopPreviews.new(@current_shop).generate_previews

        format.html { redirect_to @stamp, notice: 'Stamp was successfully created.' }
        format.json { render :show, status: :created, location: @stamp }
      else
        format.html { render :new }
        format.json { render json: @stamp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stamps/1
  # PATCH/PUT /stamps/1.json
  def update
    respond_to do |format|
      if @stamp.update(stamp_params)
        format.html { redirect_to @stamp, notice: 'Stamp was successfully updated.' }
        format.json { render :show, status: :ok, location: @stamp }
      else
        format.html { render :edit }
        format.json { render json: @stamp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stamps/1
  # DELETE /stamps/1.json
  def destroy
    @stamp.destroy
    respond_to do |format|
      format.html { redirect_to stamps_url, notice: 'Stamp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def preview
    @product_images = @current_shop.product_images.sample(3)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stamp
      @stamp = @current_shop.stamps.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stamp_params
      params.require(:stamp).permit(:name, :watermark_id, :rotate, :transparency, :position, :tiled)
    end
end
